{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.difftastic";
  package = pkgs.difftastic;
}
