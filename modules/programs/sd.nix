{ delib, pkgs, ... }:
delib.module {
  name = "programs.sd";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      sd
    ];
  };
}
