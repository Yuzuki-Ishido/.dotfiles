#!/usr/bin/bash

WALLPAPER_DIR="$HOME/.config/backgrounds"
WALLPAPER_MAP="$HOME/.config/hypr/wallpapers.txt"
PAUSE_FILE="$HOME/.cache/wallpaper_rotation_paused"
BACKUP_WALLPAPER="$WALLPAPER_DIR/cyrene.jpg"

# Rotation interval in seconds
ROTATION_INTERVAL=3600 # 1 hour
PAUSE_DURATION=$((3 * 3600)) # 3 hours = 10800 seconds

# make sure pause file does not exist before loop
if [ -f "$PAUSE_FILE" ]; then
	echo "[wallpaper-rotate] Clearing stale pause file."
	rm -f "$PAUSE_FILE"
fi

sleep 1

# Ensure mapping file exists
if [ ! -f "$WALLPAPER_MAP" ]; then
	echo "[wallpaper-rotate] Wallpaper map not found, exiting."
	exit 1
fi


echo "[wallpaper-rotate] Script started at $(date)" > tmp/wallpaper-log
while true; do
	# Check if rotation is paused
	if [ -f "$PAUSE_FILE" ]; then
		TIMESTAMP=$(cat "$PAUSE_FILE")
		NOW=$(date +%s)
		ELAPSED=$(( NOW - TIMESTAMP))

		if [ "$ELAPSED" -lt "$PAUSE_DURATION" ]; then
			# Still in pause period, sleep for a short duration
			sleep 60
			continue
		else
			# Pause expired, remove pause file
			rm -f "$PAUSE_FILE"
		fi
	fi

	# Pick a random wallpaper line
	RANDOM_LINE=$(grep -v '^#' "$WALLPAPER_MAP" | grep -v '^$' | shuf -n1)
	FILE=$(echo "$RANDOM_LINE" | cut -d'|' -f2)
	WALLPAPER="$WALLPAPER_DIR/$FILE"

	if [ -z "$RANDOM_LINE" ]; then
		echo "[wallpaper-rotate] No valid entries in wallpaper map."
		sleep 60
		continue
	fi

	# Fallback if file missing
	if [ ! -f "$WALLPAPER" ]; then
		echo "[wallpaper-rotate] Warning: '$FILE' missing, using backup wallpaper."
		WALLPAPER="$BACKUP_WALLPAPER"
	fi

	# Apply wallpaper
	# hyprctl hyprpaper unload all
	# hyprctl hyprpaper preload "$WALLPAPER"
	hyprctl hyprpaper wallpaper ",$WALLPAPER,cover"

	echo "[wallpaper-rotate] Applied wallpaper: $(basename "$WALLPAPER")"

	# Sleep for rotation interval
	sleep "$ROTATION_INTERVAL"
done
