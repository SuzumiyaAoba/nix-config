{ delib, pkgs, ... }:
delib.module {
  name = "programs.ditaa";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      ditaa
    ];
  };
}
