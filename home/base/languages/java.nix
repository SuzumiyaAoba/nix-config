{ pkgs, ... }:

{
  home.packages = with pkgs; [
    openjdk17
    lombok
  ];
}
