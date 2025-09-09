{ delib, ... }:
delib.module {
  name = "session";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.sessionVariables = {
      EDITOR = "emacs";
      COLORTERM = "truecolor";
    };
  };
}
