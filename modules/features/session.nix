{ delib, ... }:
delib.module {
  name = "features.session";

  options = delib.singleEnableOption true;

  home.ifEnabled = { myconfig, ... }: {
    home.sessionVariables = {
      EDITOR =
        if myconfig.programs.emacs.enable then
          "emacs"
        else if myconfig.programs.neovim.enable then
          "nvim"
        else
          "vi";
      COLORTERM = "truecolor";
    };
  };
}
