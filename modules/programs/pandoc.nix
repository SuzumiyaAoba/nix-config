{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.pandoc";
  package = pkgs.pandoc;
}
