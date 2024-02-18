{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmigemo
  ];
}
