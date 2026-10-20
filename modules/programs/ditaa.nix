{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.ditaa";
  package = pkgs.ditaa;
}
