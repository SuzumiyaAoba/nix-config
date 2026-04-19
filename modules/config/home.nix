{
  delib,
  inputs,
  pkgs,
  ...
}:
let
  direnvOverlay = final: prev: {
    direnv = prev.direnv.overrideAttrs (_old: {
      # The fish test is killed on aarch64-darwin during local system builds.
      doCheck = false;
    });
    mise = (prev.mise.override { direnv = final.direnv; }).overrideAttrs (_old: {
      # Avoid rebuilding the full mise test suite for system activation builds.
      doCheck = false;
    });
  };
in
delib.module {
  name = "home";

  darwin.always = {
    nixpkgs.overlays = [
      direnvOverlay
    ];
  };

  home.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      nix = {
        settings = {
          "experimental-features" = [
            "nix-command"
            "flakes"
          ];
        };
      };
      nixpkgs.overlays = [
        inputs.moonbit-overlay.overlays.default
        direnvOverlay
      ];
      home = {
        inherit username;
        # If you don't need Nix-Darwin, or if you're using it exclusively,
        # you can keep the string here instead of the condition.
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
      };
    };
}
