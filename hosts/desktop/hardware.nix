{ delib, ... }:
delib.host {
  name = "desktop";

  system = "aarch64-darwin";

  homeManagerUser = "suzumiyaaoba";
  useHomeManagerModule = true;

  home.home.stateVersion = "25.05";

  darwin = {
    system.stateVersion = 6;
  };
}
