{ delib, ... }:
let
  braveBundleId = "com.brave.Browser";
  vimiumExtensionId = "dbepggeogbaibhgnhhndojpepiihcmeb";
  chromeWebStoreUpdateUrl = "https://clients2.google.com/service/update2/crx";
in
delib.module {
  name = "homebrew.brave-browser";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "brave-browser"
    ];

    # Brave は Chromium の ExtensionSettings policy を解釈できるため、
    # Vimium 本体の自動インストールまでは system policy で管理します。
    # ただし Vimium の設定値自体は storage.managed 非対応なので自動反映できません。
    system.activationScripts.braveVimiumPolicy.text = ''
      install -d -m 755 "/Library/Managed Preferences"
      cat > "/Library/Managed Preferences/${braveBundleId}.plist" <<'EOF'
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>ExtensionSettings</key>
        <dict>
          <key>${vimiumExtensionId}</key>
          <dict>
            <key>installation_mode</key>
            <string>force_installed</string>
            <key>update_url</key>
            <string>${chromeWebStoreUpdateUrl}</string>
          </dict>
        </dict>
      </dict>
      </plist>
      EOF
      chown root:wheel "/Library/Managed Preferences/${braveBundleId}.plist"
      chmod 0644 "/Library/Managed Preferences/${braveBundleId}.plist"
    '';
  };
}
