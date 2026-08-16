#!/usr/bin/env bash

# Spotify JSON / $INFO comes in malformed, line below sanitizes it
PLAYER="$(echo "$INFO" | jq -r '.app')"
PLAYERSTATE="$(echo "$INFO" | jq -r '.state')"
CURRENTARTIST="$(echo "$INFO" | jq -r '.artist')"
CURRENTSONG="$(echo "$INFO" | jq -r '.title')"

update_widget() {
  if [[ "$PLAYER" = "Music" || "$PLAYER" = "Spotify" ]]; then
    ARGS=(drawing=on background.image=media.artwork)
  fi

  sketchybar --set $NAME "${ARGS[@]}"
}

mouse_clicked() {
  if [[ "$MODIFIER" == "shift" ]]; then
    osascript -e 'tell application "Spotify" to next track'
  elif [[ "$MODIFIER" == "none" ]]; then
    osascript -e 'tell application "Spotify" to playpause'
  fi
}

case "$SENDER" in
"media_change")
  update_widget
  ;;
"mouse.clicked")
  mouse_clicked
  ;;
esac
