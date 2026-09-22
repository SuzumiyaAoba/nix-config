{ delib, pkgs, ... }:
let
  allowedUnfreePackages = [
    "appcleaner"
    "datagrip"
    "goland"
    "oracle-instantclient"
    "rust-rover"
  ];

  unfreeConfig = {
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (pkgs.lib.getName pkg) allowedUnfreePackages;
  };
in
delib.module {
  name = "unfree";

  home.always = unfreeConfig;
  darwin.always = unfreeConfig;
}
