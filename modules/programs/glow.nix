{ delib, pkgs, ... }:
delib.module {
  name = "programs.glow";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      glow
    ];
  };
}
