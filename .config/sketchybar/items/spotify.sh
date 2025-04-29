#!/bin/bash

music=(
  background.corner_radius=4
  background.height=32
  background.color=$COLOR_TRANSPARENT
  background.image.corner_radius=4
  background.image.scale=0.9
  background.image.padding_left=10
  icon.padding_right=34
  label.max_chars=24
  label.padding_right=4
  label.scroll_duration=200
  scroll_texts=on
  updates=on
  script="$PLUGIN_DIR/spotify.sh"
  click_script="$PLUGIN_DIR/spotify.sh"
  --subscribe music media_change mouse.clicked
)

sketchybar \
  --add item music right \
  --set music "${music[@]}"
