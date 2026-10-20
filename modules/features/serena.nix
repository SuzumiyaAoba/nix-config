{ delib, ... }:
delib.module {
  name = "features.serena";
  options = delib.singleEnableOption false;

  home.ifEnabled.home.file.".serena".source = ../../home/.serena;
}
