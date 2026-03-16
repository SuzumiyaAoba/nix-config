{ delib, pkgs, ... }:
let
  aerospaceConfigPath = ../../home/.config/aerospace/aerospace.toml;
in
delib.module {
  name = "programs.aerospace";

  options = delib.singleEnableOption pkgs.stdenv.isDarwin;

  home.ifEnabled = {
    programs.aerospace = {
      enable = true;
      userSettings = builtins.fromTOML (builtins.readFile aerospaceConfigPath);
    };
  };
}
