{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.tokei";
  package = pkgs.tokei;
}
