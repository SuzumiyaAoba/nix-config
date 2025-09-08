{ delib, pkgs, ... }:
delib.module {
  name = "programs.vhs";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      vhs
    ];
  };
}
