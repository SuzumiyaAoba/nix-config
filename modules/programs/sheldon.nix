{ delib, pkgs, ... }:
delib.module {
  name = "programs.sheldon";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      sheldon
    ];
  };
}
