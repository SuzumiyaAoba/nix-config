{ delib, pkgs, ... }:
delib.module {
  name = "programs.jq";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      jq
    ];
  };
}
