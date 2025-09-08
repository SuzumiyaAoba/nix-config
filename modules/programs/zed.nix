{ delib, pkgs, ... }:
delib.module {
  name = "programs.zed";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      zed-editor
    ];
  };
}
