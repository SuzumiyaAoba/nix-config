{ delib, userConfig, ... }:
delib.host {
  name = "desktop";
  type = "desktop";

  homeManagerUser = userConfig.username;
  useHomeManagerModule = true;

  myconfig.features = {
    base.enable = true;
    development.enable = true;
    research.enable = true;
    personal.enable = true;
  };
}
