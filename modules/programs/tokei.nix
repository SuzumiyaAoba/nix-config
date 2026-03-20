{ delib, pkgs, ... }:
delib.module {
  name = "programs.tokei";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      tokei
    ];
  };
}
