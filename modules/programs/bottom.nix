{ delib, ...}:
delib.module {
  name = "programs.bottom";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.bottom = {
      enable = true;
    };
  };
}
