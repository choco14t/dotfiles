{ pkgs, ... }:

{
  imports = [ ./modules/common.nix ];

  home.username = "choco14t";
  home.homeDirectory = "/Users/choco14t";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    podman
    railway
  ];
}
