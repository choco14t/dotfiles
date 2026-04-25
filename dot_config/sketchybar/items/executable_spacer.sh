#!/bin/bash

spacer=(
  width=12
  icon.padding_left=0
  icon.padding_right=0
  padding_left=0
  padding_right=0
)

sketchybar \
  --add item "spacer_$1_$2" $2 \
  --set "spacer_$1_$2" "${spacer[@]}"
