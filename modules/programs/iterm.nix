{ delib, pkgs, ... }:
delib.module {
  name = "programs.iterm";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      iterm2
    ];
  };
}
