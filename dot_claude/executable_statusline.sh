#!/bin/bash

# Pattern 1: Minimal dots - colored circles with numbers only
# https://nyosegawa.com/posts/claude-code-statusline-rate-limits/

data=$(cat)

R=$'\033[0m'
DIM=$'\033[2m'
BOLD=$'\033[1m'

gradient() {
  local pct=$1
  if ((pct < 50)); then
    local r=$((pct * 51 / 10))
    printf '\033[38;2;%d;200;80m' "$r"
  else
    local g=$((200 - (pct - 50) * 4))
    ((g < 0)) && g=0
    printf '\033[38;2;255;%d;60m' "$g"
  fi
}

dot() {
  local pct=$1
  local p=$(printf '%.0f' "$pct")
  printf '%s●%s %s%s%%%s' "$(gradient "$p")" "$R" "$BOLD" "$p" "$R"
}

jq_get() {
  echo "$data" | jq -r "$1 // empty"
}

model=$(echo "$data" | jq -r '.model.display_name // "Claude"')
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
sep="  ${DIM}·${R}  "

effort=$(jq_get '.effort.level')

line1="${BOLD}${model}${R}"
if [ -n "$effort" ]; then
  line1="${line1}${sep}${DIM}effort:${R}${BOLD}${effort}${R}"
fi
if [ -n "$branch" ]; then
  line1="${line1}${sep}${DIM}${branch}${R}"
fi

line2=""
ctx=$(jq_get '.context_window.used_percentage')
if [ -n "$ctx" ]; then
  line2="ctx $(dot "$ctx")"
fi

five=$(jq_get '.rate_limits.five_hour.used_percentage')
if [ -n "$five" ]; then
  [ -n "$line2" ] && line2="${line2}${sep}"
  line2="${line2}5h $(dot "$five")"
fi

week=$(jq_get '.rate_limits.seven_day.used_percentage')
if [ -n "$week" ]; then
  [ -n "$line2" ] && line2="${line2}${sep}"
  line2="${line2}7d $(dot "$week")"
fi

output="$line1"
if [ -n "$line2" ]; then
  output="${output}"$'\n'"${line2}"
fi

printf '%s' "$output"
