{ delib, ... }:
delib.module {
  name = "programs.fzf";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.fzf = {
      enable = true;
    };
  };
}
