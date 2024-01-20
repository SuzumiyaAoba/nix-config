{ username, ... }:

{
  system = {
    activationScripts.postActivation.text = ''
      sudo -u ${username} defaults write com.apple.dock persistent-apps -array "<dict>
                <key>tile-data</key>
                <dict>
                    <key>file-data</key>
                    <dict>
                        <key>_CFURLString</key>
                        <string>file:///System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app/</string>
                        <key>_CFURLStringType</key>
                        <integer>15</integer>
                    </dict>
                </dict>
            </dict>"

      killall Dock
    '';
  };
}
