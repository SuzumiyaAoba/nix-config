{ delib, pkgs, ... }:
delib.module {
  name = "programs.fzy";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      fzy
    ];
  };
}
