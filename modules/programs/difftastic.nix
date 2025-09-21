{ delib, pkgs, ... }:
delib.module {
  name = "programs.difftastic";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      difftastic
    ];
  };
}
