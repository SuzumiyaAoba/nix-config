{ delib, pkgs, ... }:
delib.module {
  name = "programs.delta";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      delta
    ];
  };
}
