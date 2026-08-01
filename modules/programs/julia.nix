{ delib, pkgs, ... }:
delib.module {
  name = "programs.julia";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      julia-bin
    ];
  };
}
