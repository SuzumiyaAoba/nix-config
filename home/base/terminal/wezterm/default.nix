{ pkgs, config, username, ... }:

{
  programs.wezterm = {
    enable = true;

    extraConfig = ''
      local config = require 'config'

      config.set_environment_variables = {
        PATH = "/etc/profiles/per-user/${username}/bin:${pkgs.nix}/bin:" .. os.getenv("PATH"),
      }

      return config
    '';
  };

  home.file = {
    ".config/wezterm/config.lua".source = ./config.lua;
    ".config/wezterm/keybinds.lua".source = ./keybinds.lua;
  };
}
