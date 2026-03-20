{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.karabiner";

  options = delib.singleEnableOption false;

  home.ifEnabled = lib.mkIf pkgs.stdenv.isDarwin {
    home.packages = with pkgs; [
      karabiner-elements
    ];
  };
}
