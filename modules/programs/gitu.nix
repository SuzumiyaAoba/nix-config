{ delib, pkgs, ... }:
delib.module {
  name = "programs.gitu";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gitu
    ];
  };
}
