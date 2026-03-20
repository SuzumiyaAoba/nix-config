{ delib, pkgs, ... }:
delib.module {
  name = "programs.gh-dash";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gh-dash
    ];
  };
}
