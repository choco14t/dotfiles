{
  description = "Home Manager configuration and dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    herdr = {
      url = "github:ogulcancelik/herdr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    backlog-md = {
      url = "github:MrLesk/Backlog.md";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      herdr,
      backlog-md,
      ...
    }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      railwayOverlay = final: prev: {
        railway = prev.railway.overrideAttrs (_: rec {
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
      backlogMdOverlay = final: _: {
        backlog-md = backlog-md.packages.${final.stdenv.hostPlatform.system}.default;
      };
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          overlays = [
            railwayOverlay
            herdr.overlays.default
            backlogMdOverlay
          ];
        };
      mkHome =
        {
          system,
          username,
          homeDirectory,
          extraModules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor system;
          modules = [
            ./home/modules/packages.nix
            ./home/modules/dotfiles.nix
            {
              home = {
                inherit username homeDirectory;
                stateVersion = "24.11";
              };
            }
          ]
          ++ extraModules;
        };

      personalDarwin = mkHome {
        system = "aarch64-darwin";
        username = "choco14t";
        homeDirectory = "/Users/choco14t";
        extraModules = [ ./home/profiles/personal.nix ];
      };
      personalLinux = mkHome {
        system = "x86_64-linux";
        username = "choco14t";
        homeDirectory = "/home/choco14t";
        extraModules = [ ./home/profiles/personal.nix ];
      };
      workDarwin = mkHome {
        system = "aarch64-darwin";
        username = builtins.getEnv "USER";
        homeDirectory = builtins.getEnv "HOME";
        extraModules = [ ./home/profiles/work.nix ];
      };
    in
    {
      homeConfigurations = {
        choco14t = personalDarwin;
        choco14t-linux = personalLinux;
        work = workDarwin;
      };

      checks = {
        aarch64-darwin.personal-home = personalDarwin.activationPackage;
        x86_64-linux.personal-home = personalLinux.activationPackage;
      };

      devShells = forAllSystems (system: {
        default = (pkgsFor system).mkShell {
          packages = [ (pkgsFor system).home-manager ];
        };
      });
    };
}
