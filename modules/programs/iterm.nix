{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.iterm";
  package = pkgs.iterm2;
}
