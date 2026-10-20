{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.appcleaner";
  package = pkgs.appcleaner;
}
