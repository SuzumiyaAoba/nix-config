{ delib, pkgs, ... }:
delib.module {
  name = "programs.ollama";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      ollama
    ];
  };
}
