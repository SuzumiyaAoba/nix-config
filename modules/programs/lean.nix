{ delib, pkgs, ... }:
delib.module {
  name = "programs.lean";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      lean4
    ];
  };
}
