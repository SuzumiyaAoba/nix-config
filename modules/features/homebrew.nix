{
  delib,
  config,
  inputs,
  ...
}:
delib.module {
  name = "features.homebrew";

  options = delib.singleEnableOption true;

  # Imports must remain unconditional so their options are available.
  darwin.always.imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  darwin.ifEnabled =
    { myconfig, ... }:
    {
      nix-homebrew = {
        enable = true;
        user = myconfig.constants.username;

        enableRosetta = true;

        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
          "nikitabobko/homebrew-tap" = inputs.aerospace-tap;
          "steipete/homebrew-tap" = inputs.steipete-tap;
        };
      };

      homebrew = {
        enable = true;
        onActivation = {
          # Upgrades run manually (`brew upgrade`) to keep darwin-rebuild fast
          # and avoid surprise version bumps during system activation.
          upgrade = false;
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

      system.activationScripts.preActivation.text = ''
        # Ensure Homebrew base dirs exist (without creating Taps preemptively)
        if [ ! -d /opt/homebrew/Library ]; then
          mkdir -p /opt/homebrew/Library
        fi
        # If an empty Taps dir exists from a previous run, remove it to avoid mkdir errors downstream
        rmdir /opt/homebrew/Library/Taps 2>/dev/null || true
        # Recursive chown is slow once Cellar grows; only run it when needed.
        if [ "$(stat -f %u /opt/homebrew)" != "$(id -u ${myconfig.constants.username})" ] \
          || [ -n "$(find /opt/homebrew -maxdepth 3 ! -user ${myconfig.constants.username} -print -quit 2>/dev/null)" ]; then
          chown -R ${myconfig.constants.username}:staff /opt/homebrew
        fi
      '';
    };
}
