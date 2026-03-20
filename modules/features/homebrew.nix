{
  delib,
  config,
  inputs,
  ...
}:
delib.module {
  name = "features.homebrew";

  options = delib.singleEnableOption true;

  darwin.always =
    { myconfig, ... }:
    {
      imports = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
      ]
      ++ (import ../../lib/homebrew-modules.nix);

      nix-homebrew = {
        enable = true;
        user = myconfig.constants.username;

        enableRosetta = true;

        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
          "daipeihust/homebrew-tap" = inputs.im-select-tap;
          "nikitabobko/homebrew-tap" = inputs.aerospace-tap;
        };
      };

      homebrew = {
        enable = true;
        onActivation = {
          upgrade = true;
          # Nix store 上の tap を Homebrew が更新しようとして
          # Permission denied になるのを避ける
          autoUpdate = false;
          cleanup = "zap";
        };
        global.autoUpdate = false;
        taps = builtins.attrNames config.nix-homebrew.taps;

        brews = [
          "grep"
          "findutils"
          "gnu-sed"
          "gettext"
        ];
      };
    };
}
