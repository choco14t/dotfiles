#!/bin/sh
set -eu

REPO="${CHEZMOI_REPO:-git@github.com:choco14t/dotfiles.git}"
BIN_DIR="${HOME}/.local/bin"

if ! command -v chezmoi >/dev/null 2>&1; then
  mkdir -p "${BIN_DIR}"
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${BIN_DIR}"
  PATH="${BIN_DIR}:${PATH}"
fi

if [ -d "${HOME}/.local/share/chezmoi/.git" ]; then
  chezmoi update
else
  chezmoi init --apply "${REPO}"
fi
