{ delib, ... }:
let
  home = ../../home;
in
delib.module {
  name = "features.config";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.file = {
      # zsh
      ".config/zsh".source = home + "/.config/zsh";
      ".p10k.zsh".source = home + "/.p10k.zsh";

      # NeoVim
      ".config/nvim/init.lua".source = home + "/.config/nvim/init.lua";
      ".config/nvim/lua".source = home + "/.config/nvim/lua";

      # wezterm
      ".config/wezterm/config.lua".source = home + "/.config/wezterm/config.lua";
      ".config/wezterm/keybinds.lua".source = home + "/.config/wezterm/keybinds.lua";

      # zellij
      ".config/zellij".source = home + "/.config/zellij";

      # mise
      ".config/mise".source = home + "/.config/mise";

      # starship
      ".config/starship.toml".source = home + "/.config/starship.toml";

      # tig
      ".tigrc".source = home + "/.tigrc";

      # serena
      ".serena".source = home + "/.serena";

      # karabiner
      ".config/karabiner".source = home + "/.config/karabiner";

      # AeroSpace
      ".config/aerospace/aerospace.toml".source = home + "/.config/aerospace/aerospace.toml";

      # Vimium
      ".config/vimium".source = home + "/.config/vimium";

      # Cursor
      ".iterm2_shell_integration.zsh".source = home + "/.iterm2_shell_integration.zsh";

      # Calude Code
      ".claude/statusline.py".source = home + "/.claude/statusline.py";
    };
  };
}
