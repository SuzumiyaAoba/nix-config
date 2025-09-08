{ delib, pkgs, ... }:
delib.module {
  name = "programs.tree";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      tree
    ];
  };
}
