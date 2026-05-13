{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    komorebi-for-mac = {
      url = "github:LGUG2Z/komorebi-for-mac";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, komorebi-for-mac, ... }:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      overlay = final: prev: {
        railway = prev.railway.overrideAttrs (oldAttrs: rec {
          version = "4.57.1";
          src = prev.fetchFromGitHub {
            owner = "railwayapp";
            repo = "cli";
            rev = "v${version}";
            hash = "sha256-DMNOYyiUAnvBrc08qPb7ayXn5gxJzXW/vOLIxRs4D2Y=";
          };
          cargoDeps = prev.rustPlatform.fetchCargoVendor {
            inherit src;
            hash = "sha256-a25cnm+xoCRhgf1gC5GQEELEsltK+hB50eg1dt/CvoI=";
          };
        });
      };
      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [ overlay komorebi-for-mac.overlays.default ];
      };
    in
    {
      homeConfigurations = {
        "choco14t" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor "aarch64-darwin";
          modules = [ ./home.nix ];
        };
        "work" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor "aarch64-darwin";
          modules = [ ./home-work.nix ];
        };
      };

      # For convenience: nix develop
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [ home-manager ];
          };
        }
      );
    };
}
