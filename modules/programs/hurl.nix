{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.hurl";
  package = pkgs.hurl;
}
