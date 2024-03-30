{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gopls
    gopkgs
    goimports-reviser
  ];
}
