{ delib, pkgs, ... }:
delib.module {
  name = "programs.delta";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      delta
    ];
  };
}
