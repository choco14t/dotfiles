set fish_greeting

# fish 4.x default theme sets fish_color_command to 'normal'; restore bold blue
set -g fish_color_command blue --bold

set -Ux LANG en_US.UTF-8
set -Ux THEME dark
set -Ux FISH_DIR $HOME/.fish
set -Ux WAKATIME_HOME $HOME/.config/wakatime
set -Ux IS_DEMO 1

set --export PATH "$HOME/.local/bin:$PATH"

switch (uname)
    case Linux
        source (dirname (status --current-filename))/linux.fish
    case Darwin
        source (dirname (status --current-filename))/darwin.fish
end

source (dirname (status --current-filename))/environments.fish
source (dirname (status --current-filename))/alias.fish

set --export PATH "$HOME/.local/bin:$PATH"
