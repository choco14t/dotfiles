if [ ! -e $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

NVIM_PATH="${HOME}/.config/nvim"
if [ ! -e $NVIM_PATH ]; then
    mkdir -p $NVIM_PATH
fi

ln -fnsv $HOME/.dotfiles/init.vim $NVIM_PATH/init.vim

