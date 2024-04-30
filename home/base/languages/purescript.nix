{ pkgs, ... }:

{
  home.packages = with pkgs; [
    purs
    spago-unstable
  ];
}
