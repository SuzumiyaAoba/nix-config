{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (callPackage ./flake.nix {})
  ];
}
