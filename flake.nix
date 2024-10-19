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

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-lsp-booster.url = "github:slotThe/emacs-lsp-booster-flake";

    xremap.url = "github:xremap/nix-flake";

    hyprland.url = "github:hyprwm/Hyprland?ref=v0.39.1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    purescript-overlay = {
      url = "github:thomashoneyman/purescript-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.39.1";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    { self
    , nixpkgs
    , darwin
    , home-manager
    , nix-homebrew
    , emacs-overlay
    , emacs-lsp-booster
    , xremap
    , hyprland
    , hyprland-plugins
    , purescript-overlay
    , hy3
    , ...
    }@inputs:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
      username = builtins.getEnv "USER";
      # username = "suzumiyaaoba";

      forAllSystems = nixpkgs.lib.genAttrs systems;

      specialArgs = {
        inherit username;
        inherit hyprland-plugins;
        inherit hy3;
      };

      configuration = { pkgs, ... }: {
        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.stateVersion = 4;

        nix.settings = {
          experimental-features = [ "nix-command" "flakes" ];
        };

        nixpkgs.overlays = [
          emacs-overlay.overlays.emacs
          emacs-lsp-booster.overlays.default
          purescript-overlay.overlays.default
        ];
      };
    in
    {
      darwinConfigurations = {
        private-aarch64-500GB = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            ./modules/darwin/system.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./hosts/macos/aarch64-500GB/home.nix;
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
            ./hosts/macos/aarch64-500GB/homebrew.nix
          ];
        };

        private-aarch64 = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            ./modules/darwin
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./hosts/macos/private/home/aarch64;
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
            ./hosts/macos/private
            ./hosts/macos/private/modules/darwin
          ];
        };

        private-x86_64 = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            ./modules/darwin
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./hosts/macos/private/home/x86_64;
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./hosts/macos/private
          ];
        };

        work = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            ./modules/darwin
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./hosts/work/home;
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./hosts/macos/work
          ];
        };
      };

      nixosConfigurations = {
        nixos-x86_64 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          inherit specialArgs;

          modules = [
            xremap.nixosModules.default
            ./hosts/nixos
            ./hosts/nixos/hardware/trigkey.nix
            ./modules/nixos/configuration.nix
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ emacs-overlay.overlays.emacs ]; })
            ./modules/nixos
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;

              home-manager.users.${username} = import ./home/nixos;
            }
            ./modules/gui/1password.nix
          ];
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}

