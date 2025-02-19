{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mysql80
  ];
}
