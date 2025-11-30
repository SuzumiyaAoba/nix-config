{ delib, pkgs, ... }:
delib.module {
  name = "programs.cmake";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      cmake
    ];
  };
}
