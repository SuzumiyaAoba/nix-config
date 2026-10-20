{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.gnupg";
  package = pkgs.gnupg;
}
