{ delib, pkgs, ... }:
delib.module {
  name = "programs.coreutils";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      coreutils
    ];
  };
}
