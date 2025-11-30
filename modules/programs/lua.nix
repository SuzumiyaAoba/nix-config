{ delib, pkgs, ... }:
delib.module {
  name = "programs.lua";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      lua-language-server
    ];
  };
}
