{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.cmigemo";
  package = pkgs.cmigemo;
}
