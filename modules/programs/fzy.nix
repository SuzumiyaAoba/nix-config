{ delib, pkgs, ... }:
delib.module {
  name = "programs.fzy";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      fzy
    ];
  };
}
