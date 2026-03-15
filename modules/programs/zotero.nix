{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.zotero";

  options = delib.singleEnableOption false;

  home.ifEnabled = lib.mkIf (!pkgs.stdenv.isDarwin) {
    home.packages = with pkgs; [
      zotero
    ];
  };

  darwin.ifEnabled = {
    homebrew.casks = [
      "zotero"
    ];
  };
}
