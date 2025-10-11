{ delib, pkgs, ... }:
delib.module {
  name = "programs.snyk";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      snyk
    ];
  };
}
