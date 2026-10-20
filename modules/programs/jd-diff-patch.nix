{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.jd-diff-patch";
  package = pkgs.jd-diff-patch;
}
