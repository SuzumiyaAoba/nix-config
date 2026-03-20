{ delib, pkgs, ... }:
delib.module {
  name = "programs.ditaa";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      ditaa
    ];
  };
}
