#!/usr/bin/bash

# get current language, 1 for English, 2 for Japanese
LANGUAGE=$(fcitx5-remote)
TOGGLE_CAPS=$(hyprctl -j devices | jq -r '.keyboards[] | select(.name=="keychron-keychron-k6") | .capsLock')

# Decide icon
if [[ "$LANGUAGE" -eq 1 ]]; then
  ICON="A"
elif [[ "$LANGUAGE" -eq 2 ]]; then
  ICON="󱌴"
  #ICON="あ"
else
  echo "[keyboard-status] Error: unsupported layout detected: defaulting to English." >&2
  ICON="A"
  fcitx5-remote -s keyboard-us
fi

# Validate Caps State
if [[ "$TOGGLE_CAPS" == "true" ]]; then
  CLASS="caps-on"
elif [[ "$TOGGLE_CAPS" == "false" ]]; then
  CLASS="caps-off"
else
  echo "[keyboard-status] Error: invalid caps state value: $TOGGLE_CAPS." >&2
  CLASS="ERR"
fi

# Output valid waybar JSON
echo "{\"text\":\"$ICON\", \"class\":\"$CLASS\"}"
