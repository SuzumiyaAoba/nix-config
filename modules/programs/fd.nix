{ delib, pkgs, ... }:
delib.module {
  name = "programs.fd";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      fd
    ];
  };
}
