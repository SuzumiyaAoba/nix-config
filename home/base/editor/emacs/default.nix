{ nixpkgs, config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit;
  };

  home.file = {
    ".emacs.d/init.el".source = ./init.el;
    ".emacs.d/early-init.el".source = ./early-init.el;
  };
}
