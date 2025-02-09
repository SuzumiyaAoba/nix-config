{ username, ... }:

{
  system = {
    defaults = {
      dock = {
        autohide = true;
      };

      # https://github.com/LnL7/nix-darwin/issues/1049#issuecomment-2323300537
      universalaccess = {
        reduceMotion = true;
      };

      finder = {
        ShowStatusBar = true;
        ShowPathbar = true;
        FXDefaultSearchScope = "SCcf";
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
      };

      trackpad = {
        ActuationStrength = 0;
        Clicking = true;
        Dragging = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        TrackpadThreeFingerTapGesture = 2;
      };

      CustomUserPreferences = {
        # https://apple.stackexchange.com/questions/91679/is-there-a-way-to-set-an-application-shortcut-in-the-keyboard-preference-pane-vi
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # Disable select the previous input source
            "60" = {
              enabled = false;
            };
            # Select the next source in the Input Menu
            "61" = {
              enabled = true;
              value = {
                parameters = [32 49 1048576];
                type = "standard";
              };
            };
            # Disable Spotlight Search
            "64" = {
              enabled = false;
            };
            # Disable Finder search window
            "65" = {
              enabled = false;
            };
            # Spaces Left - Control, Left
            "79" = {
              enabled = true;
              value = {
                parameters = [65535 123 8650752];
                type = "standard";
              };
            };
            # Spaces Right - Control, Right
            "81" = {
              enabled = true;
              value = {
                parameters = [65535 124 8650752];
                type = "standard";
              };
            };
            # Switch to Space 1 - Control, 1
            "118" = {
              enabled = true;
              value = {
                parameters = [65535 18 262144];
                type = "standard";
              };
            };
            # Switch to Space 2 - Control, 2
            "119" = {
              enabled = true;
              value = {
                parameters = [65535 19 262144];
                type = "standard";
              };
            };
            # Switch to Space 3 - Control, 3
            "120" = {
              enabled = true;
              value = {
                parameters = [65535 20 262144];
                type = "standard";
              };
            };
            # Switch to Space 4 - Control, 4
            "121" = {
              enabled = true;
              value = {
                parameters = [65535 21 262144];
                type = "standard";
              };
            };
          };
        };
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    activationScripts.postActivation.text = ''
      sudo -u ${username} defaults write com.apple.controlcenter.plist Bluetooth -int 18
      sudo -u ${username} defaults write com.apple.controlcenter.plist Sound -int 18
      sudo -u ${username} defaults write com.apple.controlcenter.plist BatteryShowPercentage -bool true
    '';
  };
}
