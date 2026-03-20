{ delib, pkgs, ... }:
delib.module {
  name = "programs.global";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      global
    ];
  };
}
