{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.ollama";
  package = pkgs.ollama;
}
