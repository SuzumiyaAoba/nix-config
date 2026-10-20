{ delib, ... }:
delib.module {
  name = "homebrew.aerospace";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "nikitabobko/tap/aerospace"
    ];
  };

  home.ifEnabled.xdg.configFile."aerospace/aerospace.toml".source =
    ../../home/.config/aerospace/aerospace.toml;
}
