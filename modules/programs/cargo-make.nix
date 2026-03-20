{ delib, pkgs, ... }:
delib.module {
  name = "programs.cargo-make";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      cargo-make
    ];
  };
}
