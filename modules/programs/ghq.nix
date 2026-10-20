{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.ghq";
  package = pkgs.ghq;
}
