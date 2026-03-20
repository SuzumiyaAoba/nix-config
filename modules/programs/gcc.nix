{ delib, pkgs, ... }:
delib.module {
  name = "programs.gcc";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gcc
      libgccjit
    ];
  };
}
