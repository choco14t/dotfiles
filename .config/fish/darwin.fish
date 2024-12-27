if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
end

if test -e (brew --prefix asdf)/libexec/asdf.fish
    source (brew --prefix asdf)/libexec/asdf.fish
end

if test -e (brew --prefix mise)
    if status is-interactive
        mise activate fish | source
    else
        mise activate fish --shims | source
    end
end
