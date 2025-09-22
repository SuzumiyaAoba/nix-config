{ delib, pkgs, ... }:
delib.module {
  name = "programs.zellij";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.zellij = {
      enable = true;

      enableZshIntegration = true;
    };
  };
}
