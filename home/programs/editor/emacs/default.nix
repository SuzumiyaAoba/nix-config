{ nixpkgs, config, pkgs, lib, ... }:

{
  home.file = {
    ".emacs.d/init.el".source = ./init.el;
    ".emacs.d/early-init.el".source = ./early-init.el;
  };

  home.activation = {
    runAfterPackageSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD ${pkgs.emacs}/bin/emacs --batch --eval "(byte-compile-file \"~/.emacs.d/early-init.el\")"
      # $DRY_RUN_CMD ${pkgs.emacs}/bin/emacs --batch --eval "(byte-compile-file \"~/.emacs.d/init.el\")"
    '';
  };
}
