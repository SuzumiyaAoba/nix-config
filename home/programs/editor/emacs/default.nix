{ pkgs, lib, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
  };

  home.file = {
    ".emacs.d/config.org".source = ./config.org;
    # ".emacs.d/init.el".source = ./init.el;
    # ".emacs.d/early-init.el".source = ./early-init.el;
  };

  home.activation = {
    runAfterPackageSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD ${pkgs.emacs}/bin/emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/config.org")'

      rm -f ~/.emacs.d/init.elc ~/.emacs.d/early-init.elc

      # $DRY_RUN_CMD ${pkgs.emacs}/bin/emacs --batch --eval '(byte-compile-file "~/.emacs.d/early-init.el")'
      # $DRY_RUN_CMD ${pkgs.emacs}/bin/emacs --batch --eval '(byte-compile-file "~/.emacs.d/init.el")'
    '';
  };
}
