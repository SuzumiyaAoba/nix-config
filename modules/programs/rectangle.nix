{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.rectangle";
  package = pkgs.rectangle;
}
