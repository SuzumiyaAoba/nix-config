{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.mkcert";
  package = pkgs.mkcert;
}
