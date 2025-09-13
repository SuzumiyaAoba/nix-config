{ delib, userConfig, ... }:
delib.host {
  name = "desktop";

  system = "aarch64-darwin";

  homeManagerUser = userConfig.username;
  useHomeManagerModule = true;

  home.home.stateVersion = "25.05";

  darwin = {
    system.stateVersion = 6;
  };
}
