{ delib, pkgs, ... }:
delib.module {
  name = "programs.gh";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gh
    ];
  };
}
