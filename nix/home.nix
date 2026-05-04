{ pkgs, ... }:

{
  home.username = "choco14t";
  home.homeDirectory = "/Users/choco14t";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

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
  ];
}
