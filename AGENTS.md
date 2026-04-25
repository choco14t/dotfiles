# AGENTS.md

## Repository purpose

Personal dotfiles repo managed by chezmoi. Source-state files use chezmoi naming such as `dot_tmux.conf`, `dot_config/`, and `executable_*`; `chezmoi apply --source .` materializes them into `$HOME`.

## Common commands

Driven by the top-level `Makefile`:

- `make init` — installs chezmoi into `~/.local/bin` if it is missing.
- `make diff` / `make status` — inspect what chezmoi would change.
- `make deploy` / `make apply` — apply this repo as the chezmoi source directory.
- `make update` — pulls `origin master`, then applies via chezmoi.

`install.sh` is the remote bootstrap. It installs chezmoi if needed and runs `chezmoi init --apply git@github.com:choco14t/dotfiles.git` on a fresh machine.

## Architecture notes

- **Deploy model is chezmoi-managed, not symlink-based.** New managed files should be added in source-state form, for example `dot_gitconfig-mac` for `~/.gitconfig-mac`.
- **`.config/` is managed as `dot_config/`.** Adding `dot_config/<app>/...` makes chezmoi manage `~/.config/<app>/...` without replacing all of `~/.config` with a symlink.
- **Executable files need the `executable_` prefix.** For example, `dot_config/yabai/executable_yabairc` applies as executable `~/.config/yabai/yabairc`.
- **Neovim** uses LazyVim (`.config/nvim/`). `lazy-lock.json` is the pinned plugin manifest — commits like "nvim: update package" come from `:Lazy update` regenerating it. Custom config lives under `.config/nvim/lua/`.
- **macOS-specific configs** (`aerospace`, `yabai`, `skhd`, `borders`, `sketchybar`, `komorebi` is Windows) coexist in `.config/`. There is no platform gating in deploy; unused tools' configs are simply inert on the current OS. `.gitconfig-mac` vs `.gitconfig-linux` is the only platform split at the top level.
