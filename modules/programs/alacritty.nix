{ delib, pkgs, ... }:
delib.module {
  name = "programs.alacritty";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      alacritty
    ];
  };
}
