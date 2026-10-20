{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.hexyl";
  package = pkgs.hexyl;
}
