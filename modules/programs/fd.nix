{ delib, pkgs, ... }:
delib.module {
  name = "programs.fd";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      fd
    ];
  };
}
