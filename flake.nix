{
  description = "Modular configuration of NixOS, Home Manager, and Nix-Darwin with Denix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    user-config = {
      url = "path:./user.example.nix";
      flake = false;
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.nix-darwin.follows = "nix-darwin";
    };

    emacs-flake = {
      url = "github:SuzumiyaAoba/emacs-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { denix, emacs-flake, ... }@inputs:
    let
      mkConfigurations =
        moduleSystem:
        denix.lib.configurations {
          inherit moduleSystem;

          paths = [
            ./hosts
            ./modules
          ];

          extensions = with denix.lib.extensions; [
            args
            (base.withConfig {
              args.enable = true;
              rices.enable = false;
            })
          ];

          specialArgs = {
            inherit inputs;
            inherit emacs-flake;
            userConfig = import inputs.user-config;
          };
        };
    in
    {
      formatter = inputs.nixpkgs.lib.genAttrs [ "aarch64-darwin" ] (
        system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        inputs.treefmt-nix.lib.mkWrapper pkgs {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
          };
          settings.global.excludes = [
            "result/**"
          ];
        }
      );
      # If you're not using NixOS, Home Manager, or Nix-Darwin,
      # you can safely remove the corresponding lines below.
      # nixosConfigurations = mkConfigurations "nixos";
      homeConfigurations = mkConfigurations "home";
      darwinConfigurations = mkConfigurations "darwin";
    };
}
