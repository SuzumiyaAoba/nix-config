{ delib, pkgs, ... }:
let
  allowedUnfreePackages = [
    "oracle-instantclient"
  ];

  unfreeConfig = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (pkgs.lib.getName pkg) allowedUnfreePackages;
  };
in
delib.module {
  name = "unfree";

  home.always = unfreeConfig;
  darwin.always = unfreeConfig;
}
