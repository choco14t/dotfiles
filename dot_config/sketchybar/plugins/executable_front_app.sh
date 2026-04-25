#!/bin/bash

ICON_PADDING_RIGHT=8

case $INFO in
"Arc")
  ICON=󰞍
  ;;
"Code")
  ICON=󰨞
  ;;
"Calendar")
  ICON=
  ;;
"Discord")
  ICON=
  ;;
"FaceTime")
  ICON=
  ;;
"Finder")
  ICON=󰀶
  ;;
"Google Chrome")
  ICON=
  ;;
"IINA")
  ICON=󰕼
  ;;
"kitty")
  ICON=󰄛
  ;;
"Messages")
  ICON=
  ;;
"Notion")
  ICON=󰎚
  ;;
"Preview")
  ICON=
  ;;
"PS Remote Play")
  ICON=
  ;;
"Spotify")
  ICON=
  ;;
"TextEdit")
  ICON=
  ;;
"Transmission")
  ICON=󰶘
  ;;
"Floorp")
  ICON=󰈹
  ;;
"Ghostty")
  ICON=󰊠
  ;;
*)
  ICON_PADDING_RIGHT=2
  ;;
esac

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" label="$INFO" icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
fi
