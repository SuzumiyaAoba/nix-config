{ pkgs, nixpkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  environment.variables = {
    EDITOR = "emacs";
  };

  time.timeZone = "Asia/Tokyo";

  imports = [
    ./base
    ./system.nix
    ./security.nix
    ./homebrew.nix
  ];
}
