{ delib, userConfig, ... }:
delib.module {
  name = "macos";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    system = {
      primaryUser = userConfig.username;

      defaults = {
        dock = {
          autohide = true;
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
      };

      keyboard = {
        enableKeyMapping = true;
        remapCapsLockToControl = true;

        userKeyMapping = [
          # {
          #   HIDKeyboardModifierMappingSrc = ;
          #   HIDKeyboardModifierMappingDst = ;
          # }
        ];
      };

      activationScripts.preActivation.text = ''
        # Ensure Homebrew base dirs exist (without creating Taps preemptively)
        if [ ! -d /opt/homebrew/Library ]; then
          mkdir -p /opt/homebrew/Library
        fi
        # If an empty Taps dir exists from a previous run, remove it to avoid mkdir errors downstream
        rmdir /opt/homebrew/Library/Taps 2>/dev/null || true
        chown -R ${userConfig.username}:staff /opt/homebrew
      '';

      activationScripts.postActivation.text = ''
        sudo -u ${userConfig.username} defaults write com.apple.controlcenter.plist Bluetooth -int 18
        sudo -u ${userConfig.username} defaults write com.apple.controlcenter.plist Sound -int 18
        sudo -u ${userConfig.username} defaults write com.apple.controlcenter.plist BatteryShowPercentage -bool true
      '';
    };

    security.pam.services.sudo_local.touchIdAuth = true;
  };
}
