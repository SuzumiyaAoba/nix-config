{
  delib,
  inputs,
  lib,
  pkgs,
  userConfig,
  ...
}:
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
