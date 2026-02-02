{ delib, pkgs, ... }:
delib.module {
  name = "programs.rust";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      cargo
    ];
  };
}
