{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jnv
  ];
}
