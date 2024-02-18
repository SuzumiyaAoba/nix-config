{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ditaa
  ];
}
