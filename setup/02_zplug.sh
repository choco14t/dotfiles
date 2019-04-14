#!/bin/bash

if [ ! -e $HOME/.zplug ]; then
    echo "install zplug."
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
else
    echo "zplug already installed."
fi
