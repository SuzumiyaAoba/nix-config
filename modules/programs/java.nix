{ delib, pkgs, ... }:
delib.module {
  name = "programs.java";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      lombok
    ];
  };
}
