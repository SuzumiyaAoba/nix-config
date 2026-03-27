{
  delib,
  inputs,
  pkgs,
  ...
}:
let
  # Workaround: nixpkgs direnv build fails with CGO_ENABLED=0 and -linkmode=external
  direnvOverlay = final: prev: {
    direnv = prev.direnv.overrideAttrs (old: {
      env = (old.env or { }) // {
        CGO_ENABLED = 1;
      };
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
