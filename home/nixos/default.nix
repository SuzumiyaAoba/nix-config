{ pkgs, lib, ... }:

{
  home.username = "suzumiyaaoba";
  home.homeDirectory = "/home/suzumiyaaoba";

  imports = [
    ../base

    ./wayland
    ./editor
    ./browser
    ./commands
  ];

  home.sessionVariables = {
    NIX_LD_LIBRARY_PATH = lib.makeLibraryPath (with pkgs; [ stdenv.cc.cc openssl libuuid ]);
    NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
  };
}
