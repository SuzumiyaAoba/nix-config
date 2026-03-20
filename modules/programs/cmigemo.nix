{ delib, pkgs, ... }:
delib.module {
  name = "programs.cmigemo";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      cmigemo
    ];
  };
}
