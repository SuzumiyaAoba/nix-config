{ delib, pkgs, ... }:
delib.module {
  name = "programs.tectonic";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      tectonic
      watchexec
    ];
  };
}
