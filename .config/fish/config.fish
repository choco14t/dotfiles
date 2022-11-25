if test -e ~/.asdf/asdf.fish
    source ~/.asdf/asdf.fish
end

if type -q starship
    starship init fish | source
end

set fish_greeting

source (dirname (status --current-filename))/alias.fish
