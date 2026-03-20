{ delib, pkgs, ... }:
delib.module {
  name = "programs.java";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      lombok
    ];
  };
}
