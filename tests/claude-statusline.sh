#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
statusline="$repo_root/files/claude/statusline.sh"

input='{
  "model": { "display_name": "Claude" },
  "context_window": {
    "total_input_tokens": 1500,
    "total_output_tokens": 2000000
  }
}'

output=$(printf '%s\n' "$input" | "$statusline")

[[ "$output" == *"1.5k"* ]] || {
  printf 'FAIL: formatted input token count is missing\n' >&2
  exit 1
}
[[ "$output" == *"2.0M"* ]] || {
  printf 'FAIL: formatted output token count is missing\n' >&2
  exit 1
}

printf 'Claude status-line tests passed.\n'
