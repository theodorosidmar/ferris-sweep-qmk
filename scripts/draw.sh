#!/usr/bin/env bash
set -euo pipefail

# Regenerates the layer images in img/ from keymap.json.
# Needs keymap-drawer: `pipx install keymap-drawer` (or set KEYMAP=/path/to/keymap).

cd "$(dirname "$0")/.."
KEYMAP=${KEYMAP:-keymap}
LAYERS=(Base Mouse Nav Sym-R Sym-L Fn Num Always)

"$KEYMAP" -c scripts/keymap_drawer.yaml parse -q keymap.json -l "${LAYERS[@]}" > img/keymap.yaml
"$KEYMAP" -c scripts/keymap_drawer.yaml draw img/keymap.yaml > img/keymap.svg
for i in "${!LAYERS[@]}"; do
  "$KEYMAP" -c scripts/keymap_drawer.yaml draw img/keymap.yaml -s "${LAYERS[$i]}" > "img/layer$i.svg"
done

echo "Images written to img/"
