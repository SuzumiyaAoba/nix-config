{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.tbls";
  package = pkgs.tbls;
}
