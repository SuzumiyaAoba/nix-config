{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.emacs-lsp-booster";
  package = pkgs.emacs-lsp-booster;
}
