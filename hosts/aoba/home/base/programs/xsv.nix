{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xsv
  ];
}
