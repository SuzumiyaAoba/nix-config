{ delib, ... }:
delib.module {
  name = "programs.zellij";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    xdg.configFile."zellij".source = ../../home/.config/zellij;

    programs.zellij = {
      enable = true;

      # enableZshIntegration = true;
    };
  };
}
