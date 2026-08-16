#!/usr/bin/env bash
set -euo pipefail

config=$(cat)

status_line='tui.status_line = ["approval-mode", "model", "git-branch", "context-used", "used-tokens", "five-hour-limit", "weekly-limit"]'
legacy_status_line='tui.status_line = ["approval-mode", "model", "git-branch", "context-used", "five-hour-limit", "weekly-limit"]'
lines="${status_line}"$'\n''tui.status_line_use_colors = true'

if printf '%s' "$config" | grep -qE 'status_line\s*='; then
  if printf '%s\n' "$config" | grep -Fqx "$legacy_status_line"; then
    config=${config/"$legacy_status_line"/"$status_line"}
  fi
  printf '%s\n' "$config"
  exit 0
fi

if [ -z "$config" ]; then
  printf '%s\n' "$lines"
  exit 0
fi

awk -v status_line="$status_line" '
  !inserted && /^\[/ {
    print status_line
    print "tui.status_line_use_colors = true"
    print ""
    inserted=1
  }
  { print }
  END {
    if (!inserted) {
      print ""
      print status_line
      print "tui.status_line_use_colors = true"
    }
  }
' <<< "$config"
