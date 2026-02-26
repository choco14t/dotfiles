if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm (installed by curl)
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
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
