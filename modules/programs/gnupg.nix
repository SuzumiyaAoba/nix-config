{ delib, pkgs, ... }:
delib.module {
  name = "programs.gnupg";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gnupg
    ];
  };
}
