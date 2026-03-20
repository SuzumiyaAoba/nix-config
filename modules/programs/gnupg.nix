{ delib, pkgs, ... }:
delib.module {
  name = "programs.gnupg";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gnupg
    ];
  };
}
