{ delib, pkgs, ... }:
delib.module {
  name = "programs.pandoc";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      pandoc
    ];
  };
}
