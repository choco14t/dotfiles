set fish_greeting

set -Ux LANG en_US.UTF-8
set -Ux THEME dark
set -Ux FISH_DIR $HOME/.fish
set -Ux WAKATIME_HOME $HOME/.config/wakatime

source (dirname (status --current-filename))/environments.fish
source (dirname (status --current-filename))/alias.fish

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
