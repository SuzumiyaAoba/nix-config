{ delib, pkgs, ... }:
delib.module {
  name = "programs.lazygit";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      lazygit
    ];
  };
}
