#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
REPO_ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd -P)
WALLS_BIN="$REPO_ROOT/bin/walls"
TEST_ROOT=""

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  exit 1
}

cleanup() {
  [[ -n "$TEST_ROOT" && "$TEST_ROOT" == /tmp/walls-smoke.* ]] || return 0
  rm -rf "$TEST_ROOT"
}

trap cleanup EXIT

[[ -x "$WALLS_BIN" ]] || fail "bin/walls no es ejecutable"

TEST_ROOT=$(mktemp -d /tmp/walls-smoke.XXXXXX)
TARGET_DIR="$TEST_ROOT/home"
mkdir -p "$TARGET_DIR"

# 1. Test listing
"$WALLS_BIN" list >/dev/null

# 2. Test link to custom target
"$WALLS_BIN" link --target "$TARGET_DIR"

[[ -L "$TARGET_DIR/.local/share/wallpapers" ]] || fail "Falta enlace a wallpapers"
[[ -L "$TARGET_DIR/.local/bin/walls" ]] || fail "Falta enlace a bin/walls"

# 3. Test doctor with custom target
"$WALLS_BIN" doctor --target "$TARGET_DIR" >/dev/null

# 4. Test unlink from custom target
"$WALLS_BIN" unlink --target "$TARGET_DIR"

[[ ! -e "$TARGET_DIR/.local/share/wallpapers" ]] || fail "Wallpapers no se desvinculó correctamente"
[[ ! -e "$TARGET_DIR/.local/bin/walls" ]] || fail "bin/walls no se desvinculó correctamente"

echo "OK: Pruebas de doctor, list, link y unlink en walls validadas exitosamente."
