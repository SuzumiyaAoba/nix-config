{ delib, pkgs, ... }:
delib.module {
  name = "programs.lmstudio";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      # lmstudio
    ];
  };
}
