# dotfiles

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Directory

This repository is a chezmoi source directory. File and directory names are written in chezmoi's source-state format.

```text
AGENTS.md                         # AI agent instructions (repo-only)
dot_tmux.conf                     # ~/.tmux.conf
dot_gitconfig.tmpl                # ~/.gitconfig (chezmoi template, OS-aware)
dot_hushlogin                     # ~/.hushlogin
dot_ideavimrc                     # ~/.ideavimrc
dot_obsidian.vimrc                # ~/.obsidian.vimrc
dot_gitignore                     # ~/.gitignore
dot_config/                       # ~/.config/
├── aerospace/                    # AeroSpace window manager
├── alacritty/                    # Alacritty terminal
├── borders/                      # borders config
├── fish/                         # fish shell config
├── fuchi/                        # fuchi config
├── ghostty/                      # Ghostty terminal
├── iterm/                        # iTerm2 color schemes
├── komorebi/                     # komorebi window manager
├── nvim/                         # Neovim / LazyVim config
├── raycast/                      # Raycast scripts
├── sketchybar/                   # SketchyBar config
├── skhd/                         # skhd hotkey config
├── starship.toml                 # Starship prompt
├── tmux/                         # tmux theme and helper scripts
├── wakatime/                     # WakaTime config template
├── wezterm/                      # WezTerm terminal
├── yabai/                        # yabai window manager
├── yashiki/                      # yashiki scripts
└── zellij/                       # Zellij terminal workspace
dot_claude/                       # ~/.claude/
├── CLAUDE.md.tmpl                # Claude Code instructions (chezmoi template)
├── executable_statusline.sh      # Claude status line script
├── settings.json                 # Claude Code settings
└── settings.local.template.json  # Template for local settings overrides
```

Repository-only files are excluded from chezmoi apply by `.chezmoiignore`.

## Setup

Install chezmoi and apply these dotfiles on a new machine:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/choco14t/dotfiles.git
```

If chezmoi is already installed:

```sh
chezmoi init --apply https://github.com/choco14t/dotfiles.git
```

Preview changes before applying:

```sh
chezmoi init https://github.com/choco14t/dotfiles.git
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
