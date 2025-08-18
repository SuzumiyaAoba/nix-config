{
  description = "Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    sdkman-tap = {
      url = "github:sdkman/homebrew-tap";
      flake = false;
    };
    homebrew-qmk = {
      url = "github:qmk/homebrew-qmk";
      flake = false;
    };
    homebrew-arm = {
      url = "github:osx-cross/homebrew-arm";
      flake = false;
    };
    homebrew-avr = {
      url = "github:osx-cross/homebrew-avr";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    emacs-flake = {
      url = "github:SuzumiyaAoba/emacs-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    , nix-darwin
    , home-manager
    , nix-homebrew
    , emacs-flake
    , xremap
    , hyprland
    , hyprland-plugins
    , purescript-overlay
    , hy3
    , homebrew-core
    , homebrew-cask
    , homebrew-bundle
    , sdkman-tap
    , homebrew-qmk
    , homebrew-arm
    , homebrew-avr
    , ...
    }@inputs:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      username = "suzumiyaaoba";

      forAllSystems = nixpkgs.lib.genAttrs systems;

      specialArgs = {
        inherit username;

        inherit homebrew-core;
        inherit homebrew-bundle;
        inherit homebrew-cask;
        inherit sdkman-tap;
        inherit homebrew-qmk;
        inherit homebrew-arm;
        inherit homebrew-avr;

        inherit hyprland-plugins;
        inherit hy3;
      };

      configuration = { pkgs, ... }: {
        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.stateVersion = 5;
        system.primaryUser = username;

        nix.settings = {
          experimental-features = [ "nix-command" "flakes" ];
        };

        nixpkgs.overlays = [
          purescript-overlay.overlays.default
        ] ++ (import ./overlays { inherit nixpkgs; });
      };
    in
    {
      darwinConfigurations = {
        private-aarch64-256GB = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./hosts/macos/aarch64-256GB/home.nix;
              home-manager.extraSpecialArgs = specialArgs;
            }
            nix-homebrew.darwinModules.nix-homebrew
            ./hosts/macos/aarch64-256GB
            ({ pkgs, ... }: {
              environment.systemPackages = [
                emacs-flake.packages.aarch64-darwin.default
                emacs-flake.packages.aarch64-darwin.emacsclient
                emacs-flake.packages.aarch64-darwin.emacseditor
              ];
            })
          ];
        };

        private-aarch64-1TB = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./hosts/macos/aarch64-1TB/home.nix;
              home-manager.extraSpecialArgs = specialArgs;
            }
            nix-homebrew.darwinModules.nix-homebrew
            ./hosts/macos/aarch64-1TB
            ({ pkgs, ... }: {
              environment.systemPackages = [
                emacs-flake.packages.aarch64-darwin.default
              ];
            })
          ];
        };

        work = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit specialArgs;

          modules = [
            configuration
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./hosts/macos/work/home.nix;
              home-manager.extraSpecialArgs = specialArgs;
            }
            nix-homebrew.darwinModules.nix-homebrew
            ./hosts/macos/work
            ({ pkgs, ... }: {
              environment.systemPackages = [
                emacs-flake.packages.aarch64-darwin.default
                emacs-flake.packages.aarch64-darwin.emacsclient
                emacs-flake.packages.aarch64-darwin.emacseditor
              ];
            })
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
            ./modules/nixos
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;

              home-manager.users.${username} = import ./home/nixos;
            }
          ];
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
