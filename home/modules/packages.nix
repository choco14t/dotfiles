{ pkgs, ... }:

let
  nvimDotfiles = pkgs.writeShellApplication {
    name = "nvim-dotfiles";
    runtimeInputs = [ pkgs.neovim ];
    text = ''
      dotfiles_root="''${DOTFILES_ROOT:-$HOME/.dotfiles}"
      nvim_config="$dotfiles_root/files/config/nvim"

      if [[ ! -f "$nvim_config/init.lua" ]]; then
        printf 'Neovim config was not found at %s\n' "$nvim_config" >&2
        exit 1
      fi

      XDG_CONFIG_HOME="$dotfiles_root/files/config" exec nvim "$@"
    '';
  };
in
{
  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    # Shell & Terminal
    fish
    starship
    tmux
    zellij

    # File & Navigation
    eza
    fd
    fzf
    ripgrep
    bat
    tree

    # Git tools
    lazygit
    gh
    ghq
    delta

    # Editor
    neovim
    nvimDotfiles

    # Development
    mise
    jq
    yq
    bc

    herdr
    backlog-md
  ];
}
