{ delib, userConfig, ... }:
delib.host {
  name = "work";
  type = "desktop";

  homeManagerUser = userConfig.username;
  useHomeManagerModule = true;

  myconfig.features = {
    base.enable = true;
    development.enable = true;
    work.enable = true;
  };
}
