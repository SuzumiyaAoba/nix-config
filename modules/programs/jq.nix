{ delib, pkgs, ... }:
delib.module {
  name = "programs.jq";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      jq
    ];
  };
}
