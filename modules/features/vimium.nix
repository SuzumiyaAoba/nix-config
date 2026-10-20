{ delib, ... }:
delib.module {
  name = "features.vimium";
  options = delib.singleEnableOption false;

  home.ifEnabled.xdg.configFile."vimium".source = ../../home/.config/vimium;
}
