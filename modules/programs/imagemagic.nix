{ delib, pkgs, ... }:
delib.module {
  name = "programs.imagemagic";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      imagemagick
    ];
  };
}
