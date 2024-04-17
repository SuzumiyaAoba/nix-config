{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password-gui
    git-credential-1password
  ];
}
