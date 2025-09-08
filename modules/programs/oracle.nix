{ delib, pkgs, ... }:
delib.module {
  name = "programs.oracle";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
      "oracle-instantclient"
    ];
    home.packages = with pkgs; [
      oracle-instantclient
    ];
  };
}
