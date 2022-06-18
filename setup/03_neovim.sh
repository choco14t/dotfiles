#!/bin/bash

if [ ! -e $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    echo "install vim-plug for neovim."
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim-plug for neovim already installed."
fi

NVIM_PATH="${HOME}/.config/nvim"
if [ ! -e $NVIM_PATH ]; then
    echo "create nvim directory."
    mkdir -p $NVIM_PATH
else
    echo "nvim directory already exist."
fi

ln -fnsv $HOME/.dotfiles/.config/init.vim $NVIM_PATH/init.vim
