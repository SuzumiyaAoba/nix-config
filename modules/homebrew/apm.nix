{ delib, ... }:
delib.module {
  name = "homebrew.apm";

  options = delib.singleEnableOption false;

  darwin.ifEnabled.homebrew.brews = [ "apm" ];
}
