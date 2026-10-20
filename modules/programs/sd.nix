{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.sd";
  package = pkgs.sd;
}
