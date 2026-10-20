{ delib, pkgs, ... }:
delib.module {
  name = "programs.tig";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.file.".tigrc".source = ../../home/.tigrc;

    home.packages = with pkgs; [
      tig
    ];
  };
}
