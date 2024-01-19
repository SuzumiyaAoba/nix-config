{
  description = "Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , darwin
    , home-manager
    , nix-homebrew
    , emacs-overlay
    , ...
    }@inputs:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
      username = builtins.getEnv "USER";

      forAllSystems = nixpkgs.lib.genAttrs systems;

      specialArgs = {
        inherit emacs-overlay;
        inherit username;
      };

      configuration = { pkgs, ... }: {
        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.stateVersion = 4;

        nix.settings = {
          experimental-features = [ "nix-command" "flakes" ];
        };
      };
    in
    {
      darwinConfigurations = {
        private-aarch64 = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            ./modules/overlays.nix
            ./modules/darwin
            home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./hosts/private/home/aarch64;
              home-manager.extraSpecialArgs = specialArgs;
            }
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = false;
                user = "${username}";
              };
            }
            ./hosts/private
            ./hosts/private/modules/darwin
          ];
        };

        private-x86_64 = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            ./modules/overlays.nix
            ./modules/darwin
            home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./hosts/private/home/x86_64;
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./hosts/private
          ];
        };

        work = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            ./modules/overlays.nix
            ./modules/darwin
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./hosts/work/home;
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./hosts/work
          ];
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}

