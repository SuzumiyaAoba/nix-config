{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ttyd
  ];
}
