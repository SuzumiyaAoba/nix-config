{ delib, pkgs, ... }:
delib.module {
  name = "programs.difftastic";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      difftastic
    ];
  };
}
