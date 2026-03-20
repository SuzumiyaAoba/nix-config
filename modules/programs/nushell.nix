{ delib, ... }:
delib.module {
  name = "programs.nushell";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.nushell = {
      enable = true;
    };
  };
}
