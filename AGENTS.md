# AGENTS.md

## Repository purpose

Personal dotfiles and packages managed by Nix and Home Manager. Home Manager
deploys the source files under `files/` to the user's home directory.

## Common commands

- `nix flake check` — evaluate the flake and build checks for the current system.
- `home-manager build --flake .#choco14t` — build the personal macOS configuration.
- `home-manager switch --flake .#choco14t` — activate the personal macOS configuration.
- `home-manager build --flake .#choco14t-linux` — build the personal Linux configuration.
- `home-manager switch --impure --flake .#work` — activate the environment-derived work configuration.
- `bash tests/codex-config.sh` — test the idempotent Codex config filter.
- `bash tests/claude-statusline.sh` — test Claude token-count formatting.
- `bash tests/home-manager.sh` — test macOS/Linux mappings and migration invariants.

## Architecture notes

- `flake.nix` stays at the repository root so the full `files/` tree is part of
  the flake source.
- Shared packages are defined in `home/modules/packages.nix`; dotfile deployment
  is defined in `home/modules/dotfiles.nix`; profile-only packages belong under
  `home/profiles/`.
- Keep application configuration in its native format under `files/`. Do not
  translate large Lua, TOML, KDL, or shell configurations into Nix expressions.
- `files/config/` maps to `$XDG_CONFIG_HOME`; `files/home/` contains selected
  files mapped directly below `$HOME`.
- macOS-only configuration is selected with `pkgs.stdenv.hostPlatform.isDarwin`. Common files
  must evaluate on both macOS and Linux.
- `files/windows/komorebi/` is tracked in Git but deliberately not deployed by
  Home Manager.
- Home Manager deploys Neovim through the Nix store. Use `nvim-dotfiles` before
  `:Lazy update` so changes to `lazy-lock.json` are written into this repository.
- Executable scripts retain their Git executable bit. Set `executable = true`
  explicitly for individually managed scripts where the mode is part of the
  deployment contract.
- The Codex status-line filter is applied from a Home Manager activation step
  because it must preserve unrelated settings in `~/.codex/config.toml`.
