{ nixpkgs, config, pkgs, ... }:

{
  home.file = {
    ".emacs.d/init.el".source = ./init.el;
    ".emacs.d/config.org".source = ./config.org;
    ".emacs.d/early-init.el".source = ./early-init.el;
    ".emacs.d/yasnippets".source = ./yasnippets;
  };
}
