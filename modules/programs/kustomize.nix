{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.kustomize";
  package = pkgs.kustomize;
}
