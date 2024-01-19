{ username, ... }:

{
  system = {
    defaults = {
      dock = {
        autohide = true;
      };

      finder = {
        ShowStatusBar = true;
        ShowPathbar = true;
        FXDefaultSearchScope = "SCcf";
        AppleShowAllFiles = true;
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

    activationScripts.postActivation.text = ''
      sudo -u ${username} defaults -currentHost write com.apple.controlcenter.plist Bluetooth -int 18
    '';
  };
}
