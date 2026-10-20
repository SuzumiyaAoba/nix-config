{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.julia";
  package = pkgs.julia-bin;
}
