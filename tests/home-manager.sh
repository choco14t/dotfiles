#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  exit 1
}

assert_eq() {
  local expected=$1
  local actual=$2
  local label=$3

  if [[ "$actual" != "$expected" ]]; then
    fail "$label: expected '$expected', got '$actual'"
  fi
}

assert_contains() {
  local json=$1
  local item=$2
  local label=$3

  jq -e --arg item "$item" 'index($item) != null' <<<"$json" >/dev/null \
    || fail "$label: missing '$item'"
}

assert_not_contains() {
  local json=$1
  local item=$2
  local label=$3

  jq -e --arg item "$item" 'index($item) == null' <<<"$json" >/dev/null \
    || fail "$label: unexpectedly contains '$item'"
}

assert_eq \
  "choco14t" \
  "$(nix eval --raw .#homeConfigurations.choco14t.config.home.username)" \
  "Darwin username"

assert_eq \
  "/Users/choco14t" \
  "$(nix eval --raw .#homeConfigurations.choco14t.config.home.homeDirectory)" \
  "Darwin home directory"

assert_eq \
  "choco14t" \
  "$(nix eval --raw .#homeConfigurations.choco14t-linux.config.home.username)" \
  "Linux username"

assert_eq \
  "/home/choco14t" \
  "$(nix eval --raw .#homeConfigurations.choco14t-linux.config.home.homeDirectory)" \
  "Linux home directory"

darwin_xdg=$(nix eval --json \
  .#homeConfigurations.choco14t.config.xdg.configFile \
  --apply builtins.attrNames)
linux_xdg=$(nix eval --json \
  .#homeConfigurations.choco14t-linux.config.xdg.configFile \
  --apply builtins.attrNames)

assert_contains "$darwin_xdg" "nvim" "Darwin XDG files"
assert_contains "$linux_xdg" "nvim" "Linux XDG files"
assert_contains "$darwin_xdg" "aerospace" "Darwin XDG files"
assert_not_contains "$linux_xdg" "aerospace" "Linux XDG files"
assert_not_contains "$darwin_xdg" "komorebi" "Darwin XDG files"
assert_not_contains "$linux_xdg" "komorebi" "Linux XDG files"

git ls-files --error-unmatch \
  files/windows/komorebi/.komorebi.json \
  files/windows/komorebi/komorebi.ahk >/dev/null

if git ls-files | rg -q '(^|/)(dot_|executable_|modify_)|\.tmpl$|^\.chezmoiignore$|wakatime'; then
  fail "chezmoi source-state or WakaTime paths remain tracked"
fi

if rg --hidden -n -i 'chezmoi|wakatime' \
  AGENTS.md README.md mise.toml flake.nix home files >/dev/null; then
  fail "chezmoi or WakaTime references remain in active configuration"
fi

nix eval --raw \
  .#homeConfigurations.choco14t-linux.activationPackage.drvPath >/dev/null

printf 'Home Manager migration tests passed.\n'
