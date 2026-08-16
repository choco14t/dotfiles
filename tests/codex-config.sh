#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
filter="$repo_root/files/codex/ensure-status-line.sh"

if [[ ! -x "$filter" ]]; then
  printf 'FAIL: missing executable filter: %s\n' "$filter" >&2
  exit 1
fi

expected='tui.status_line = ["approval-mode", "model", "git-branch", "context-used", "five-hour-limit", "weekly-limit"]
tui.status_line_use_colors = true'

actual=$(printf '' | "$filter")
[[ "$actual" == "$expected" ]] || {
  printf 'FAIL: empty config was not initialized correctly\n' >&2
  exit 1
}

input='model = "gpt-5"

[projects."/tmp/example"]
trust_level = "trusted"'
actual=$(printf '%s\n' "$input" | "$filter")
expected_with_input='model = "gpt-5"

'"$expected"'

[projects."/tmp/example"]
trust_level = "trusted"'
[[ "$actual" == "$expected_with_input" ]] || {
  printf 'FAIL: settings were not inserted before the first table\n' >&2
  exit 1
}

actual_twice=$(printf '%s\n' "$actual" | "$filter")
[[ "$actual_twice" == "$actual" ]] || {
  printf 'FAIL: filter is not idempotent\n' >&2
  exit 1
}

printf 'Codex config filter tests passed.\n'
