{ nixpkgs, config, pkgs, lib, ... }:

{
  home.file = {
    ".emacs.d/init.el".source = ./init.el;
    #   ".emacs.d/config.org".source = ./config.org;
    ".emacs.d/early-init.el".source = ./early-init.el;
    #   ".emacs.d/yasnippets".source = ./yasnippets;
  };

  # home.file.".emacs.d" = {
  #   source = builtins.fetchGit {
  #     url = "https://github.com/syl20bnr/spacemacs";
  #     rev = "36b52f1b71f52718b9c35e79d35f41556529c4bd";
  #   };
  #   recursive = true;
  # };

  # home.file.".spacemacs" = {
  #   source = ./.spacemacs;
  # };

  home.activation = {
    runAfterPackageSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD ${pkgs.emacs}/bin/emacs --batch --eval "(byte-compile-file \"~/.emacs.d/early-init.el\")"
      # $DRY_RUN_CMD ${pkgs.emacs}/bin/emacs --batch --eval "(byte-compile-file \"~/.emacs.d/init.el\")"
    '';
  };
}
