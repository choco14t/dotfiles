{ pkgs, ... }:

{
  programs.home-manager.enable = true;

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

    # Development
    mise
    jq
    yq

    # Window Manager
    komorebi-full
  ];
}
