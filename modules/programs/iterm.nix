{ delib, pkgs, ... }:
delib.module {
  name = "programs.iterm";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      iterm2
    ];
  };
}
