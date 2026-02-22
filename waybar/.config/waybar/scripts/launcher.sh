#!/usr/bin/bash

MENU_MAP="$HOME/.config/waybar/scripts/launcher-options.txt"

# Ensure Menu map file exists
if [ ! -f "$MENU_MAP" ]; then
  echo "[launcher] Error: menu file not found." >&2
  exit 1
fi

# Generate menu from first field (text before '|' )
CHOICE=$(cut -d'|' -f1 "$MENU_MAP" \
  | wofi --dmenu --prompt "Menu" --hide-search --x 0 --y 30 --width 250)

# Exit if nothing happened
if [ -z "$CHOICE" ]; then
  exit 0
fi

# Find the corresponding command to selected choice
CMD=$(awk -F'|' -v choice="$CHOICE" '{
  gsub(/^ +| +$/,"",$1)
  if ($1 == choice) print $2
  }' "$MENU_MAP")

# Exit if something went wrong
if [ -z "$CMD" ]; then
  echo "[lancher] Warning: selection '$CHOCIE' invalid." >&2
  exit 1
fi

# Execute command
eval "$CMD" &
