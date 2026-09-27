{
  delib,
  inputs,
  lib,
  pkgs,
  userConfig,
  ...
}:
let
  # Some ollama revisions ship postPatch removing a test file that is absent
  # in the fetched source; make the removal tolerant instead of patching it out.
  ollamaOverlay = _final: prev: {
    ollama = prev.ollama.overrideAttrs (old: {
      postPatch =
        builtins.replaceStrings
          [ "rm model/models/nemotronh/model_omni_test.go" ]
          [ "rm -f model/models/nemotronh/model_omni_test.go" ]
          old.postPatch;
    });
  };

  direnvOverlay = final: prev: {
    direnv = prev.direnv.overrideAttrs (_old: {
      # The fish test is killed on aarch64-darwin during local system builds.
      doCheck = false;
    });
    mise = (prev.mise.override { inherit (final) direnv; }).overrideAttrs (_old: {
      # Avoid rebuilding the full mise test suite for system activation builds.
      doCheck = false;
    });
  };

  overlays = [
    ollamaOverlay
    inputs.moonbit-overlay.overlays.default
    direnvOverlay
  ];
in
delib.module {
  name = "home";

  darwin.always = {
    home-manager = {
      backupFileExtension = "backup";
      # Reuse the system pkgs so overlays are applied once.
      useGlobalPkgs = true;
    };
    nix = {
      package = inputs.nix.packages.${pkgs.stdenv.hostPlatform.system}.nix;
      settings = {
        # darwin-rebuild passes these itself, but root/daemon nix invocations
        # read /etc/nix/nix.conf, so keep them enabled system-wide too.
        "experimental-features" = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [ userConfig.username ];
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
      optimise.automatic = true;
    };
    nixpkgs.overlays = overlays;
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
      targets.darwin = lib.optionalAttrs pkgs.stdenv.isDarwin {
        copyApps.enable = true;
        linkApps.enable = false;
      };
      home = {
        inherit username;
        # If you don't need Nix-Darwin, or if you're using it exclusively,
        # you can keep the string here instead of the condition.
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
      };
    };
}
