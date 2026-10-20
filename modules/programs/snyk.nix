{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.snyk";
  package = pkgs.snyk;
}
