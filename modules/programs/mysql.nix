{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.mysql";
  package = pkgs.mysql84;
}
