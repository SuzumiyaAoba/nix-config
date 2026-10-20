{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.cargo-make";
  package = pkgs.cargo-make;
}
