{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.coreutils";
  package = pkgs.coreutils;
}
