{ delib, ... }:
let
  home = ../../home;
in
delib.module {
  name = "features.config";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.file = {
      # nix
      ".config/nix/nix.conf".source = home + "/.config/nix/nix.conf";

      # zsh
      ".config/zsh".source = home + "/.config/zsh";

      ".p10k.zsh".source = home + "/.p10k.zsh";

      # sheldom
      ".config/sheldon".source = home + "/.config/sheldon";

      # wezterm
      ".config/wezterm/config.lua".source = home + "/.config/wezterm/config.lua";
      ".config/wezterm/keybinds.lua".source = home + "/.config/wezterm/keybinds.lua";

      # mise
      ".config/mise".source = home + "/.config/mise";

      # starship
      ".config/starship.toml".source = home + "/.config/starship.toml";

      # tig
      ".tigrc".source = home + "/.tigrc";

      # serena
      ".serena".source = home + "/.serena";

      # karabiner
      ".config/karabiner/karabiner.json".source = home + "/.config/karabiner/karabiner.json";
      ".config/karabiner/assets".source = home + "/.config/karabiner/assets";
    };
  };
}
