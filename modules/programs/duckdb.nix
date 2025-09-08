{ delib, pkgs, ... }:
delib.module {
  name = "programs.duckdb";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      duckdb
    ];
  };
}
