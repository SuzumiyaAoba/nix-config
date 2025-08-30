{ delib, pkgs, ... }:
delib.module {
  name = "programs.coreutils";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      coreutils
    ];
  };
}
