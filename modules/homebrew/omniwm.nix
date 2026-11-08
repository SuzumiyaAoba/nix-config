{ delib, ... }:
delib.module {
  name = "homebrew.omniwm";

  options = delib.singleEnableOption false;

  darwin.ifEnabled.homebrew.casks = [ "omniwm" ];
}
