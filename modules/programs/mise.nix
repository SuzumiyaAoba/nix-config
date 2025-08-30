{ delib, pkgs, ... }:
delib.module {
  name = "programs.mise";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      mise
    ];
  };
}
