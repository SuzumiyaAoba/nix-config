{ delib, ... }:
let
  isPrivate = true;
in
delib.host {
  name = "desktop";

  type = "desktop";

  homeManagerUser = "suzumiyaaoba";
  useHomeManagerModule = true;

  myconfig.host.isPrivate = isPrivate;
  myconfig.programs.ollama.enable = isPrivate;

  features.config.enable = true;
}
