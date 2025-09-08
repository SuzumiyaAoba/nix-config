{ delib, pkgs, ... }:
delib.module {
  name = "programs.sd";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      sd
    ];
  };
}
