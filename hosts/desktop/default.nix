{ delib, ... }:
delib.host {
  name = "desktop";

  type = "desktop";

  homeManagerUser = "suzumiyaaoba";
  useHomeManagerModule = true;

  myconfig.host.isPrivate = true;
  myconfig.host.enableOllama = true;

  features.config.enable = true;
}
