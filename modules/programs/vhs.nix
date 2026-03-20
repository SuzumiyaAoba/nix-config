{ delib, pkgs, ... }:
delib.module {
  name = "programs.vhs";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      vhs
    ];
  };
}
