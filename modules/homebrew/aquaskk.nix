{ delib, ... }:
let
  repoHome = ../../home;
in
delib.module {
  name = "homebrew.aquaskk";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "aquaskk"
    ];
  };

  home.ifEnabled = {
    home.file."Library/Application Support/AquaSKK/BlacklistApps.plist" = {
      source = repoHome + "/.config/aquaskk/BlacklistApps.plist";
      force = true;
      onChange = ''
        /usr/bin/pkill -TERM -x AquaSKK >/dev/null 2>&1 || true
      '';
    };
  };
}
