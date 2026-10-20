{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.vhs";
  package = pkgs.vhs;
}
