{ delib, pkgs, ... }:
delib.module {
  name = "programs.glow";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      glow
    ];
  };
}
