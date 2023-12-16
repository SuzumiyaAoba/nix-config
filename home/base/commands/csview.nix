{ pkgs, ... }:

{
  home.packages = with pkgs; [
    csview
  ];
}
