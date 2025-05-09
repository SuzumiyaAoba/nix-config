{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lombok
  ];
}
