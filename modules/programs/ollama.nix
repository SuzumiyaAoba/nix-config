{ delib, pkgs, ... }:
delib.module {
  name = "programs.ollama";

  options = delib.singleEnableOption true;

  home.ifEnabled = { myconfig, cfg, ... }: {
    home.packages = with pkgs; [
      ollama
    ];
  };
}
