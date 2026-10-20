{ delib, ... }:
delib.module {
  name = "programs.karabiner";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "karabiner-elements"
    ];
  };

  home.ifEnabled.xdg.configFile."karabiner".source = ../../home/.config/karabiner;
}
