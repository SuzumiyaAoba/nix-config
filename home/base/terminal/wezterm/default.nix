{ pkgs, config, ... }:

{
  programs.wezterm = {
    enable = true;

    extraConfig = ''
      local config = require 'config'

      config.set_environment_variables = {
        PATH = "${config.home.homeDirectory}/.nix-profile/bin:${pkgs.nix}/bin:" .. os.getenv("PATH"),
      }

      return config
    '';
  };

  home.file = {
    ".config/wezterm/config.lua".source = ./config.lua;
  };
}
