switch (uname)
case Linux
    if test -e ~/.asdf/asdf.fish
      source ~/.asdf/asdf.fish
    end
case Darwin
    if test -e $(brew --prefix asdf)/libexec/asdf.fish
      source $(brew --prefix asdf)/libexec/asdf.fish
    end
end

if type -q starship
    starship init fish | source
end

if [ -d $FISH_DIR ] && [ -r $FISH_DIR ] && [ -x $FISH_DIR ]
    for file in (ls $FISH_DIR/*.fish)
        source $file
    end
end

