{ delib, pkgs, ... }:
delib.module {
  name = "programs.hurl";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      hurl
    ];
  };
}
