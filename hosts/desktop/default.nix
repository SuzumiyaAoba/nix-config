{ delib, ... }:
delib.host {
  name = "desktop";

  type = "desktop";

  features.config.enable = true;
}
