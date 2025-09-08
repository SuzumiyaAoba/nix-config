{ delib, pkgs, ... }:
delib.module {
  name = "programs.uv";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      uv
    ];
  };
}
