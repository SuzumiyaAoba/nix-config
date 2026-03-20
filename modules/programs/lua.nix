{ delib, pkgs, ... }:
delib.module {
  name = "programs.lua";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      lua-language-server
    ];
  };
}
