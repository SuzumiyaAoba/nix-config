{ delib, pkgs, ... }:
delib.module {
  name = "programs.mysql";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      mysql80
    ];
  };
}
