{ delib, pkgs, ... }:
delib.module {
  name = "programs.tree";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      tree
    ];
  };
}
