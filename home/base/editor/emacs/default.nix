{ nixpkgs, config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
  };

  home.file = {
    ".emacs.d/init.el".source = ./init.el;
    ".emacs.d/early-init.el".source = ./early-init.el;
    ".emacs.d/yasnippets".source = ./yasnippets;
  };
}
