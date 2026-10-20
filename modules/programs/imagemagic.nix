{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.imagemagic";
  package = pkgs.imagemagick;
}
