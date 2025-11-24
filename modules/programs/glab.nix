{ delib, pkgs, ... }:
delib.module {
  name = "programs.glab";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      glab
    ];
  };
}
