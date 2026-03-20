{ delib, pkgs, ... }:
delib.module {
  name = "programs.mkcert";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      mkcert
    ];
  };
}
