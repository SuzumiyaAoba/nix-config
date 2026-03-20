{ delib, ... }:
delib.module {
  name = "programs.eza";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.eza = {
      enable = true;

      icons = "always";
      colors = "always";
      enableZshIntegration = true;
    };
  };
}
