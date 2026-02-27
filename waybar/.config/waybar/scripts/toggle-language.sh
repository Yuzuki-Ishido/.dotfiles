#!/usr/bin/bash

CURRENT=$(fcitx5-remote -n)
JAPANESE="mozc"
ENGLISH="keyboard-us"

if [[ "$CURRENT" == "$JAPANESE" ]]; then
  fcitx5-remote -s "$ENGLISH"
elif [[ "$CURRENT" == "$ENGLISH" ]]; then
  fcitx5-remote -s "$JAPANESE"
else
  echo "[toggle-language] Unexpected keyboard layout detected, default to English." >&2
  fcitx5-remote -s "$ENGLISH"
fi
