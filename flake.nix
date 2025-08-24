{
  description = "Modular configuration of NixOS, Home Manager, and Nix-Darwin with Denix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
  };

  outputs =
    { denix, ... }@inputs:
    let
      mkConfigurations =
        moduleSystem:
        denix.lib.configurations {
          inherit moduleSystem;
          homeManagerUser = "suzumiyaaoba"; # !!! REPLACEME

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
          };
        };
    in
    {
      # If you're not using NixOS, Home Manager, or Nix-Darwin,
      # you can safely remove the corresponding lines below.
      # nixosConfigurations = mkConfigurations "nixos";
      homeConfigurations = mkConfigurations "home";
      darwinConfigurations = mkConfigurations "darwin";
    };
}
