{ delib, pkgs, ... }:
import ../../lib/package-module.nix {
  inherit delib;
  name = "programs.ffmpeg";
  package = pkgs.ffmpeg;
}
