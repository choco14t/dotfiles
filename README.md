# dotfiles

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Directory

This repository is a chezmoi source directory. File and directory names are written in chezmoi's source-state format.

| Source path | Applied path |
| --- | --- |
| `dot_config/` | `~/.config/` |
| `dot_tmux.conf` | `~/.tmux.conf` |
| `dot_gitconfig-mac` | `~/.gitconfig-mac` |
| `dot_gitconfig-linux` | `~/.gitconfig-linux` |
| `dot_claude/` | `~/.claude/` |
| `executable_*` | executable file without the prefix |

Examples:

```text
dot_config/nvim/init.lua -> ~/.config/nvim/init.lua
dot_config/nvim/dot_gitignore -> ~/.config/nvim/.gitignore
dot_config/yabai/executable_yabairc -> ~/.config/yabai/yabairc
```

Repository-only files are excluded from chezmoi apply by `.chezmoiignore`.

## Setup

Install chezmoi and apply these dotfiles on a new machine:

```sh
curl -fs "https://raw.githubusercontent.com/choco14t/dotfiles/master/install.sh" | bash
```

Manual setup:

```sh
chezmoi init git@github.com:choco14t/dotfiles.git
chezmoi diff
chezmoi apply
```

When working from this checkout directly, pass the source directory explicitly:

```sh
chezmoi diff --source ~/.dotfiles
chezmoi apply --source ~/.dotfiles
```

After `chezmoi init` has created `~/.local/share/chezmoi`, the short commands work:

```sh
chezmoi diff
chezmoi apply
chezmoi update
```
