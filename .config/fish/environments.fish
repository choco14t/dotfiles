if [ -d $FISH_DIR ] && [ -r $FISH_DIR ] && [ -x $FISH_DIR ]
    for file in (ls $FISH_DIR/*.fish)
        source $file
    end
end

if command -q starship
    starship init fish | source
end
