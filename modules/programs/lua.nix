{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.lua";
  package = pkgs.lua-language-server;
}
