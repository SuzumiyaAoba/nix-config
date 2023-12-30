{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    aliases = {
      tree = "log --graph --pretty=format:'%x09%C(auto) %h %Cgreen %ar %Creset%x09by %C(cyan ul)%an%Creset %x09%C(auto)%s %d'";
      logd = "log -p --ext-diff";
    };

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

    # delta = {
    #   enable = true;

    #   options = {
    #     navigatge = true;
    #     light = false;
    #     syntax-theme = "gruvbox-dark";
    #     side-by-side = true;
    #     line-numbers = true;
    #     hyperlinks = true;
    #     hyperlinks-file-link-format = "vscode://file/{path}:{line}";
    #   };
    # };

    diff-so-fancy = {
      enable = false;
    };

    difftastic = {
      enable = true;

      # display = "inline";
      background = "dark";
    };
  };
}
