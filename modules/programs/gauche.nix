{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.gauche";
  package = pkgs.gauche;
}
