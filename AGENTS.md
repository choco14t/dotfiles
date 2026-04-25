# AGENTS.md

## Repository purpose

Personal dotfiles repo. Files at the top level (`.zshrc`, `.tmux.conf`, `.vimrc`, `.gitconfig-*`, etc.) and the `.config/` directory are symlinked into `$HOME` by `make deploy`. Edits here become live config after re-running deploy (or immediately, since symlinks point back into the repo).

## Common commands

Driven by the top-level `Makefile`:

- `make init` — runs every script in `setup/` (Homebrew bootstrap + tool installs, neovim plug, tmux tpm).
- `make deploy` — symlinks every dotfile (`.??*`) at the repo root into `$HOME`. `.config/` is symlinked as a whole; individual subdirs are not linked separately.
- `make clean` — removes those symlinks from `$HOME`.
- `make list` / `make help` — inspect what would be deployed and the available targets.

`install.sh` is the remote bootstrap (clones the repo to `~/.dotfiles`, then runs `make init && make deploy`).

## Architecture notes

- **Deploy model is symlink-based, not copy-based.** `Makefile` globs `.??*` at the repo root and links each into `$HOME`. New top-level dotfiles are picked up automatically; anything that should *not* be deployed must be added to `EXCLUSIONS` in the Makefile.
- **`.config/` is one symlink.** Because deploy links the whole `.config` directory, adding a new app config under `.config/<app>/` requires no Makefile change, but it also means `~/.config` becomes a symlink to this repo — destructive if the user already has a real `~/.config`.
- **`setup/` scripts are ordered by numeric prefix** (`01_brew.sh`, `03_neovim.sh`, `05_tmux.sh`) and are all idempotent (guard with `brew ls --versions`, `[ ! -e ... ]`, etc.). Add new setup steps as `NN_name.sh`; preserve idempotency.
- **Neovim** uses LazyVim (`.config/nvim/`). `lazy-lock.json` is the pinned plugin manifest — commits like "nvim: update package" come from `:Lazy update` regenerating it. Custom config lives under `.config/nvim/lua/`.
- **macOS-specific configs** (`aerospace`, `yabai`, `skhd`, `borders`, `sketchybar`, `komorebi` is Windows) coexist in `.config/`. There is no platform gating in deploy; unused tools' configs are simply inert on the current OS. `.gitconfig-mac` vs `.gitconfig-linux` is the only platform split at the top level.
