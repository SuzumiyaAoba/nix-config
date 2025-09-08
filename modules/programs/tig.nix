{ delib, pkgs, ... }:
delib.module {
  name = "programs.tig";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      tig
    ];
  };
}
