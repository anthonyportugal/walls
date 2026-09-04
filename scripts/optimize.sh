#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
REPO_ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd -P)

quality=${1:-95}

find_tool() {
  if command -v magick >/dev/null 2>&1; then
    printf 'magick\n'
  elif command -v cwebp >/dev/null 2>&1; then
    printf 'cwebp\n'
  elif command -v convert >/dev/null 2>&1; then
    printf 'convert\n'
  else
    printf 'none\n'
  fi
}

TOOL=$(find_tool)
if [[ "$TOOL" == none ]]; then
  printf 'Error: Se necesita ImageMagick (magick/convert) o libwebp (cwebp) instalado.\n' >&2
  exit 1
fi

printf 'Optimizando fondos a WebP (calidad: %s%%) usando: %s\n' "$quality" "$TOOL"

count=0
while IFS= read -r file; do
  [[ -f "$file" ]] || continue
  webp_file="${file%.*}.webp"
  
  if [[ -f "$webp_file" && "$file" -ot "$webp_file" ]]; then
    continue
  fi

  orig_size=$(stat -c%s "$file")

  case "$TOOL" in
    magick)
      magick "$file" -quality "$quality" "$webp_file"
      ;;
    convert)
      convert "$file" -quality "$quality" "$webp_file"
      ;;
    cwebp)
      cwebp -q "$quality" "$file" -o "$webp_file" >/dev/null 2>&1
      ;;
  esac

  new_size=$(stat -c%s "$webp_file")
  savings=$(( (orig_size - new_size) * 100 / orig_size ))

  printf '  ✓ %s -> %s (-%d%%)\n' "${file##*/}" "${webp_file##*/}" "$savings"
  (( count++ )) || true
done < <(find "${REPO_ROOT}/wallpapers" -maxdepth 2 -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) ! -path '*/.*' 2>/dev/null)

printf 'Completado: %d imagen(es) procesada(s).\n' "$count"
