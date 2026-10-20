{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.oracle";
  package = pkgs.oracle-instantclient;
}
