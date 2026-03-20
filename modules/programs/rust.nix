{ delib, pkgs, ... }:
delib.module {
  name = "programs.rust";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      cargo
    ];
  };
}
