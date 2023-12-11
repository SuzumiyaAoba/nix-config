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

    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { self, nixpkgs, darwin, home-manager, emacs-overlay, ... }@inputs:
    let
      specialArgs = {
        inherit emacs-overlay;
      };

      configuration = { pkgs, ... }: {
        services.nix-daemon.enable = true;
        nix.package = pkgs.nix;

        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.stateVersion = 4;
      };
    in
    {
      darwinConfigurations = {
        personal = darwin.lib.darwinSystem {
          system = "aarch64-darwin";

          modules = [
            configuration
          ];
        };

        darwinPackages = self.darwinConfigurations.personal.pkgs;
      };
    };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimize-store = true;

    eval-cache = true;

    substituters = [
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}

