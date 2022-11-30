set fish_greeting
set -Ux LANG en_US.UTF-8
set -Ux FISH_DIR $HOME/.fish

source (dirname (status --current-filename))/environments.fish
source (dirname (status --current-filename))/alias.fish
