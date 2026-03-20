{ delib, pkgs, ... }:
delib.module {
  name = "programs.powerlevel10k";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      zsh-powerlevel10k
    ];
  };
}
