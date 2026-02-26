if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
end

if test -e ~/.local/bin/mise
    if status is-interactive
        ~/.local/bin/mise activate fish | source
    else
        ~/.local/bin/mise activate fish --shims | source
    end
else if test -e (brew --prefix mise 2>/dev/null)
    if status is-interactive
        mise activate fish | source
    else
        mise activate fish --shims | source
    end
end
