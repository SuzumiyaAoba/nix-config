{ delib, pkgs, ... }:
delib.module {
  name = "programs.zellij";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      zellij
    ];
  };
}
