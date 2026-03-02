{ delib, pkgs, ... }:
delib.module {
  name = "programs.imagemagic";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      imagemagick
    ];
  };
}
