{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.gh-dash";
  package = pkgs.gh-dash;
}
