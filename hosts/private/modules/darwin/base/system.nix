{ pkgs, username, ... }:

let
  persistentApps = [
    "/System/Applications/Launchpad.app/"
    "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app/"
    "/Applications/Brave%20Browser.app/"
    "${pkgs.vscode}/Applications/Visual%20Studio%20Code.app/"
    "${pkgs.emacs}/Applications/Emacs.app/"
    "${pkgs.wezterm}/Applications/WezTerm.app/"
    "${pkgs.jetbrains.idea-ultimate}/Applications/IntelliJ%20IDEA.app/"
  ];
  defaultsPersistentApp = path:
    ''
      sudo -u ${username} defaults -currentHost delete com.apple.dock persistent-apps
      sudo -u ${username} defaults -currentHost write com.apple.dock persistent-apps -array-add "<dict>
        <key>tile-data</key>
        <dict>
          <key>file-data</key>
          <dict>
            <key>_CFURLString</key>
            <string>file://${path}</string>
            <key>_CFURLStringType</key>
            <integer>15</integer>
          </dict>
        </dict>
      </dict>"
    '';
  defaultsPersistentApps = map defaultsPersistentApp persistentApps;
in
{
  system = {
    activationScripts.postActivation.text = ''
      sudo -u ${username} defaults delete com.apple.dock persistent-apps
      ${builtins.concatStringsSep "\n" defaultsPersistentApps}

      killall Dock

      open -a "Brave Browser" --args --make-default-browser
    '';
  };
}
