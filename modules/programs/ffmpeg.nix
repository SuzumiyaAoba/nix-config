{ delib, pkgs, ... }:
delib.module {
  name = "programs.ffmpeg";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      ffmpeg
    ];
  };
}
