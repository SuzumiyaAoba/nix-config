{ delib, ... }:
let
  home = ../../home;
in
delib.module {
  name = "features.config";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    # nix
    home.file.".config/nix/nix.conf".source = home/.config/nix/nix.conf;

    # zsh
    home.file.".config/zsh".source = home/.config/zsh;

    # sheldom
    home.file.".config/sheldon".source = home/.config/sheldon;

    # wezterm
    home.file.".config/wezterm/config.lua".source = home/.config/wezterm/config.lua;
    home.file.".config/wezterm/keybinds.lua".source = home/.config/wezterm/keybinds.lua;

    # mise
    home.file.".config/mise".source = home/.config/mise;

    # starship
    home.file.".config/starship.toml".source = home/.config/starship.toml;
  };
}
