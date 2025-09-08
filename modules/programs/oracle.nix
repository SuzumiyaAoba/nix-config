{ delib, pkgs, ... }:
delib.module {
  name = "programs.oracle";

  options = delib.singleEnableOption true;

  darwin.always = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
      "oracle-instantclient"
    ];
  };

  home.ifEnabled = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
      "oracle-instantclient"
    ];
    home.packages = with pkgs; [
      oracle-instantclient
    ];
  };
}
