{ delib, ... }:
delib.module {
  name = "features.config";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    # nix
    home.file.".config/nix/nix.conf".source = ../../.config/nix/nix.conf;

    # zsh
    home.file.".config/zsh".source = ../../.config/zsh;

    # sheldom
    home.file.".config/sheldon".source = ../../.config/sheldon;

    # wezterm
    home.file.".config/wezterm/config.lua".source = ../../.config/wezterm/config.lua;
    home.file.".config/wezterm/keybinds.lua".source = ../../.config/wezterm/keybinds.lua;

    # mise
    home.file.".config/mise".source = ../../.config/mise;

    # starship
    home.file.".config/starship.toml".source = ../../.config/starship.toml;
  };
}
