{ delib, pkgs, ... }:
delib.module {
  name = "programs.gcc";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gcc
      libgccjit
    ];
  };
}
