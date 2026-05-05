{ pkgs, ... }:

{
  imports = [ ./modules/common.nix ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "24.11";
}
