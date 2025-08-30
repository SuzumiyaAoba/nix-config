{ delib, pkgs, ... }:
delib.module {
  name = "programs.mkcert";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      mkcert
    ];
  };
}
