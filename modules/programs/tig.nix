{ delib, pkgs, ... }:
delib.module {
  name = "programs.tig";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      tig
    ];
  };
}
