{ delib, pkgs, ... }:
delib.module {
  name = "programs.mise";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      mise
    ];
  };
}
