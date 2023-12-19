{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _1password-gui
    git-credential-1password
  ];
}
