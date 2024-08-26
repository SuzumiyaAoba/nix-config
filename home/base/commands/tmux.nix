{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    prefix = "C-t";

    mouse = true;

    plugins = [
      pkgs.tmuxPlugins.pain-control
      pkgs.tmuxPlugins.power-theme
    ];
  };
}