#!/bin/bash

front_app=(
  icon.font="Moralerspace Radon NF:Bold:16.0"
  label.font="Moralerspace Radon NF:Bold:13.0"
  background.corner_radius=4
  background.height=32
  background.color=$FUTABA_BLUE
  background.border_color=$FUTABA_CYAN_75
  background.border_width=1
  icon.padding_left=10
  icon.drawing=on
  label.padding_right=10
  script="$PLUGIN_DIR/front_app.sh"
  --subscribe front_app front_app_switched
)

sketchybar \
  --add item front_app left \
  --set front_app "${front_app[@]}"
