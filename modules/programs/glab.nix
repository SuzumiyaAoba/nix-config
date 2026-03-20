{ delib, pkgs, ... }:
delib.module {
  name = "programs.glab";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      glab
    ];
  };
}
