{ delib, pkgs, ... }:
delib.module {
  name = "programs.latex";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      texliveFull
    ];
  };
}
