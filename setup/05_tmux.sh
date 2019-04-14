#!/bin/bash

TPM_PATH="${HOME}/.tmux/plugins/tpm"
if [ ! -e "${TPM_PATH}" ]; then
  echo "clone tpm"
  git clone https://github.com/tmux-plugins/tpm $TPM_PATH
else
  echo "tpm already installed."
fi
