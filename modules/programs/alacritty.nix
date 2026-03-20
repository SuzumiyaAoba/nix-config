{ delib, pkgs, ... }:
delib.module {
  name = "programs.alacritty";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      alacritty
    ];
  };
}
