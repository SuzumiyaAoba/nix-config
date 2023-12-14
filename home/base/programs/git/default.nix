{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
    ];

    extraConfig = {
      merge = {
        conflictStyle = "diff3";
      };
    };

    delta = {
      enable = true;

      options = {
        navigatge = true;
        light = false;
        syntax-theme = "gruvbox-dark";
        side-by-side = true;
        line-numbers = true;
        hyperlinks = true;
        hyperlinks-file-link-format = "vscode://file/{path}:{line}";
      };
    };
  };
}
