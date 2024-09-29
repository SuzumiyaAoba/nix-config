{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tbls
  ];
}
