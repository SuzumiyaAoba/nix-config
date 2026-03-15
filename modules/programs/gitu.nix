{ delib, pkgs, ... }:
delib.module {
  name = "programs.gitu";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gitu
    ];
  };
}
