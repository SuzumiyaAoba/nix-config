{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.cmake";
  package = pkgs.cmake;
}
