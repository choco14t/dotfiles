#!/bin/bash

clock=(
  background.color=$FUTABA_GREEN1
  background.corner_radius=4
  background.height=32
  background.border_width=1
  background.border_color=$FUTABA_ORANGE_75
  label.padding_left=8
  label.padding_right=8
  update_freq=30
  script="$PLUGIN_DIR/clock.sh"
)

sketchybar \
  --add item clock right \
  --set clock "${clock[@]}"
