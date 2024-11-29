{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc14
  ];
}
