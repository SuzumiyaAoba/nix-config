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

  # With home-manager.useGlobalPkgs the Home Manager side shares the
  # system pkgs, so the predicate only needs to be set on darwin.
  darwin.always = unfreeConfig;
}
