DOTPATH="${HOME}/.dotfiles"
if [ ! -e "${DOTPATH}" ]; then git clone git@github.com:choco14t/dotfiles.git "${DOTPATH}"; fi
cd ~/.dotfiles
make init
make deploy
