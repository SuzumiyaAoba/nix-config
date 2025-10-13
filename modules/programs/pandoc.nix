{ delib, pkgs, ... }:
delib.module {
  name = "programs.pandoc";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      pandoc
    ];
  };
}
