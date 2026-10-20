{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.lazygit";
  package = pkgs.lazygit;
}
