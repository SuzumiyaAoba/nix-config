{ delib, pkgs, ... }:
delib.module {
  name = "programs.uv";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      uv
    ];
  };
}
