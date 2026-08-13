{ delib, ... }:
delib.module {
  name = "homebrew.rtk";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.brews = [
      "rtk"
    ];
  };
}
