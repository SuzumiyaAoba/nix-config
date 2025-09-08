{ delib, ... }:
let
  isPrivate = false;
in
delib.host {
  name = "work";
  type = "desktop";

  config.host.isPrivate = isPrivate;
  myconfig.programs = {
    ollama.enable = isPrivate;
  };
}
