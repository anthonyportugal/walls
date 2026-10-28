#!/usr/bin/env bash
# Smoke tests for the collection tool bin/walls.
# Installation, links, doctor, sync, update and unlink belong to the public
# dotfiles CLI (`dotfiles add walls`); this suite checks only list, add,
# update-readme and help, plus the removed commands' refusal.
set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
REPO_ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd -P)
WALLS_BIN="$REPO_ROOT/bin/walls"
TEST_ROOT=""

# 1x1 PNG used as the input image for `walls add`.
PNG_1X1='iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg=='

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  exit 1
}

pass() {
  printf 'ok: %s\n' "$*"
}

cleanup() {
  [[ -n "$TEST_ROOT" && -d "$TEST_ROOT" ]] || return 0
  rm -rf -- "$TEST_ROOT"
}

trap cleanup EXIT

[[ -x "$WALLS_BIN" ]] || fail "bin/walls is not executable"

TEST_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/walls-smoke.XXXXXX")
SCRATCH_HOME="$TEST_ROOT/home"
mkdir -p -- "$SCRATCH_HOME" "$TEST_ROOT/links"

# Run walls with an isolated HOME and no TTY on stdin.
run_walls() {
  HOME="$SCRATCH_HOME" XDG_DATA_HOME="" "$@" </dev/null
}

# --- list through a symlink resolves the real repository --------------------
ln -s -- "$WALLS_BIN" "$TEST_ROOT/links/walls"
expected_count=$(find "$REPO_ROOT/wallpapers" -maxdepth 2 -type f -name '*.webp' | wc -l)
(( expected_count > 0 )) || fail "the collection has no WebP wallpapers"

list_out=$(cd "$TEST_ROOT" && run_walls "$TEST_ROOT/links/walls" list) \
  || fail "walls list through a symlink exited non-zero"
grep -q "Total: $expected_count wallpaper(s) en WebP." <<<"$list_out" \
  || fail "walls list did not report $expected_count wallpapers: $list_out"
grep -qF "$REPO_ROOT/wallpapers/w-001.webp" <<<"$list_out" \
  || fail "walls list did not resolve wallpapers/ through the symlink"
pass "list through a symlink"

# --- help lists only the collection commands ---------------------------------
help_out=$(run_walls "$WALLS_BIN" help)
for cmd in list add update-readme help; do
  grep -qE "^  walls $cmd( |$)" <<<"$help_out" || fail "help does not list '$cmd'"
done
for cmd in setup sync update link unlink doctor; do
  if grep -qE "^  walls $cmd( |$)" <<<"$help_out"; then
    fail "help still lists removed command '$cmd'"
  fi
done
grep -qF 'dotfiles add walls' <<<"$help_out" || fail "help does not point to 'dotfiles add walls'"
es_help=$(run_walls "$WALLS_BIN" --lang es help)
grep -q '^Uso:' <<<"$es_help" || fail "help --lang es is not in Spanish"
pass "help"

# --- no arguments without a TTY prints usage, never a wizard -----------------
noarg_out=$(run_walls "$WALLS_BIN") || fail "walls without arguments exited non-zero"
grep -q '^Usage:' <<<"$noarg_out" || fail "walls without arguments did not print usage"
pass "no arguments prints usage"

# --- removed engine commands refuse and touch nothing ------------------------
for cmd in setup sync update link unlink doctor; do
  status=0
  err=$(run_walls "$WALLS_BIN" "$cmd" 2>&1 >/dev/null) || status=$?
  (( status != 0 )) || fail "walls $cmd should fail (removed command)"
  grep -qF 'dotfiles' <<<"$err" || fail "walls $cmd does not point to the dotfiles CLI: $err"
done
[[ -z "$(find "$SCRATCH_HOME" -mindepth 1 -print -quit)" ]] \
  || fail "removed commands wrote into HOME: $(find "$SCRATCH_HOME" -mindepth 1)"
pass "removed commands refuse"

# --- unknown command fails ---------------------------------------------------
if run_walls "$WALLS_BIN" bogus >/dev/null 2>&1; then
  fail "an unknown command should fail"
fi
pass "unknown command fails"

# --- add converts into the collection and refreshes the README gallery -------
if command -v magick >/dev/null 2>&1 || command -v cwebp >/dev/null 2>&1 || command -v convert >/dev/null 2>&1; then
  COPY="$TEST_ROOT/repo"
  mkdir -p -- "$COPY/bin"
  cp -- "$WALLS_BIN" "$COPY/bin/walls"
  cp -- "$REPO_ROOT/README.md" "$COPY/README.md"
  cp -R -- "$REPO_ROOT/wallpapers" "$COPY/wallpapers"
  ln -s -- "$COPY/bin/walls" "$TEST_ROOT/links/walls-copy"

  run_walls "$TEST_ROOT/links/walls-copy" update-readme >/dev/null || fail "walls update-readme exited non-zero"
  cmp -s "$REPO_ROOT/README.md" "$COPY/README.md" \
    || fail "update-readme is not a no-op on an up-to-date README: $(diff "$REPO_ROOT/README.md" "$COPY/README.md")"
  base64 -d <<<"$PNG_1X1" >"$TEST_ROOT/input.png"

  next=$(printf 'w-%03d.webp' "$(( expected_count + 1 ))")
  (cd "$TEST_ROOT" && run_walls "$TEST_ROOT/links/walls-copy" add "$TEST_ROOT/input.png" >/dev/null) \
    || fail "walls add exited non-zero"
  [[ -s "$COPY/wallpapers/$next" ]] || fail "walls add did not create wallpapers/$next"
  [[ ! -e "$REPO_ROOT/wallpapers/$next" ]] || fail "walls add wrote into the real repository"
  [[ ! -e "$COPY/wallpapers/input.png" ]] || fail "walls add copied the source image"
  grep -qF "wallpapers/$next" "$COPY/README.md" || fail "README gallery was not updated with $next"
  grep -qF "($(( expected_count + 1 )) available)" "$COPY/README.md" || fail "README gallery count was not updated"

  (cd "$TEST_ROOT" && run_walls "$TEST_ROOT/links/walls-copy" add "$TEST_ROOT/input.png" --name custom >/dev/null) \
    || fail "walls add --name exited non-zero"
  [[ -s "$COPY/wallpapers/custom.webp" ]] || fail "walls add --name did not create custom.webp"
  pass "add and README gallery"
else
  printf 'SKIP: add (no magick, cwebp or convert available)\n'
fi

echo "OK: walls smoke tests passed."
