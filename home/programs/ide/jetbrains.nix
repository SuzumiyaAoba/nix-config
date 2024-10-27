{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    jetbrains.datagrip
    jetbrains.rider
    jetbrains.rust-rover
    jetbrains.goland
  ];
}
