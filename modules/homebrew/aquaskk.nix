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
    home.file."Library/Application Support/AquaSKK/BlacklistApps.plist".source =
      repoHome + "/.config/aquaskk/BlacklistApps.plist";
    home.file."Library/Application Support/AquaSKK/BlacklistApps.plist".force = true;
  };
}
