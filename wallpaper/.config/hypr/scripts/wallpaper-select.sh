#!/usr/bin/bash

WALLPAPER_DIR="$HOME/.config/backgrounds/"
WALLPAPER_MAP="$HOME/.config/hypr/wallpapers.txt"
PAUSE_FILE="$HOME/.cache/wallpaper_rotation_paused"
BACKUP_WALLPAPER="$WALLPAPER_DIR/cyrene.jpg"

# Ensure mapping file exists
if [ ! -f "$WALLPAPER_MAP" ]; then
	exit 1
fi

# Generate menu from first field (text before |)
CHOICE=$(cut -d'|' -f1 "$WALLPAPER_MAP" \
	| wofi --dmenu --hide-search --prompt "Select Wallpaper")

# Exit if nothing selected
if [ -z "$CHOICE" ]; then
	exit 0
fi

# Extract corresponding filename safely
SELECTED_FILE=$(awk -F'|' -v choice="$CHOICE" \
	'$1 == choice { print $2 }' "$WALLPAPER_MAP")

# Exit if something went wrong
if [ -z "$SELECTED_FILE" ]; then
	echo "[wallpaper-select] Warning: selection invalid, using backup wallpaper." >&2
	WALLPAPER="$BACKUP_WALLPAPER"
else
	WALLPAPER="$WALLPAPER_DIR/$SELECTED_FILE"
fi


# Apply wallpaper
#hyprctl hyprpaper unload all
#hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ",$WALLPAPER,cover"

# Pause rotation timer
printf "%s\n" "$(date +%s)" > "$PAUSE_FILE"
