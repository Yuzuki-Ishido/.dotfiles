#!/usr/bin/bash

SPEAKERS="alsa_output.pci-0000_0d_00.4.analog-stereo"
HEADPHONES="alsa_output.usb-DeSheng_Electronics_Inc._Jeecoo-V20U_2021.12.13-00.analog-stereo"

CURRENT=$(pactl get-default-sink)

if [ "$CURRENT" = "$SPEAKERS" ]; then
  TARGET=$HEADPHONES
else
  TARGET=$SPEAKERS
fi

# set default audio sink
pactl set-default-sink "$TARGET"

# move all active audio streams to target sink
for INPUT in $(pactl list short sink-inputs | awk '{print $1}'); do
  pactl move-sink-input "$INPUT" "$TARGET"
done
