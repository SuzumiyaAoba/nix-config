{ delib, pkgs, ... }:
delib.module {
  name = "programs.zotero";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      zotero
    ];
  };
}
