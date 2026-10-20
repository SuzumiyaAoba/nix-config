{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.fzy";
  package = pkgs.fzy;
}
