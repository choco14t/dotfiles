# dotfiles

Personal packages and dotfiles managed by Nix and Home Manager.

## Repository layout

```text
flake.nix                 # Home Manager configurations and development shells
flake.lock                # Pinned Nix inputs
home/
├── modules/              # Shared packages and dotfile deployment
└── profiles/             # Personal and work-specific settings
files/
├── home/                 # Files deployed directly below $HOME
├── config/               # Files deployed below $XDG_CONFIG_HOME
├── claude/               # Claude Code configuration
├── codex/                # Codex configuration helpers
└── windows/komorebi/     # Tracked Windows configuration; not deployed by Home Manager
examples/                 # Local-only configuration examples
```

Home Manager targets macOS and Linux. The Komorebi files remain in Git for use
on Windows, but this repository does not install them automatically.

## Fresh-machine setup

Install Nix, clone the repository, and run the matching Home Manager
configuration. The extra feature flag lets the first invocation use the flake
before Home Manager has written the persistent Nix setting.

```sh
git clone https://github.com/choco14t/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Personal Apple Silicon Mac
nix --extra-experimental-features 'nix-command flakes' develop \
  -c home-manager switch --flake .#choco14t

# Personal x86_64 Linux machine
nix --extra-experimental-features 'nix-command flakes' develop \
  -c home-manager switch --flake .#choco14t-linux
```

The work profile reads `USER` and `HOME` from the environment and therefore
requires impure evaluation:

```sh
nix develop -c home-manager switch --impure --flake .#work
```

When migrating an existing home directory, use a unique backup suffix for the
first activation so Home Manager does not overwrite unmanaged files:

```sh
nix develop -c home-manager switch -b pre-home-manager --flake .#choco14t
```

## Daily use

Apply the current configuration:

```sh
home-manager switch --flake ~/.dotfiles#choco14t
```

Preview and build it without activating:

```sh
home-manager build --flake ~/.dotfiles#choco14t
```

## Herdr desktop

The `Futaba` layout migrates the terminal Herdr configuration to `herdr-app`.
It follows system appearance with the `futaba` / `oracle` terminal
palettes, places tabs at the bottom, hides the tab row for a single tab, and
removes gaps between panes. Select it with `herdr-app do layout.switch --name Futaba`.
Fonts and other app preferences stay in the app-managed `settings.json`.

`Ctrl+K` opens the prefix menu instead of deleting to the end of the shell line.
The original arrow shortcuts work while a terminal has focus. After the prefix,
`h/j/k/l` focus panes, `v/-` split, `x` closes a pane, `c` creates a tab,
`p/n/1–9` switch tabs, `Tab/Shift+Tab` cycle panes, and `Alt+g` opens Lazygit.
`Shift+W` uses the standard picker in place of Corral; splits and closes use
the app's standard behavior in place of herdr-paddock.

`Cmd+B` toggles the left sidebar; `Cmd+Shift+B` toggles the right Files/Changes
panel. Switch Files/Changes using the tabs inside that panel, independently of
the main tab row. The prefix menu also provides `b` for the left sidebar and
`Shift+B` for the right panel. Panel selection and visibility are remembered per
space, including when a single main tab hides the tab row.

Legacy resize mode, scrollback editing, pane renaming, notification-target
navigation, sidebar row templates, and TUI-only session options have no direct
mapping here. Configuration reloads automatically. The standard app shortcuts
remain available alongside the migrated bindings.

## Updating Neovim plugins

The deployed Neovim configuration is immutable because Home Manager links it
through the Nix store. Launch Neovim with the repository copy as its config
directory when updating `lazy-lock.json`:

```sh
nvim-dotfiles
```

Then run `:Lazy update` and commit the resulting
`files/config/nvim/lazy-lock.json` change. Set `DOTFILES_ROOT` when working from
another checkout:

```sh
DOTFILES_ROOT="$PWD" nvim-dotfiles
```

## Verification

```sh
nix flake check
```
