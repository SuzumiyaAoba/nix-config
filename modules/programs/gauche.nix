{ delib, pkgs, ... }:
delib.module {
  name = "programs.gauche";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gauche
    ];
  };
}
