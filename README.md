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
tests/                    # Migration and configuration contract tests
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
bash tests/codex-config.sh
bash tests/claude-statusline.sh
bash tests/home-manager.sh
nix flake check
```
