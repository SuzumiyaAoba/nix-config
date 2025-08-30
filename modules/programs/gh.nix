{ delib, pkgs, ... }:
delib.module {
  name = "programs.gh";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gh
    ];
  };
}
