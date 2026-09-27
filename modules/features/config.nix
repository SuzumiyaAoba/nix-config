{ delib, ... }:
delib.module {
  name = "features.config";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.file = {
      # zsh
      ".config/zsh".source = ../../home/.config/zsh;
      ".p10k.zsh".source = ../../home/.p10k.zsh;

      # NeoVim
      ".config/nvim".source = ../../home/.config/nvim;

      # wezterm
      ".config/wezterm/config.lua".source = ../../home/.config/wezterm/config.lua;
      ".config/wezterm/keybinds.lua".source = ../../home/.config/wezterm/keybinds.lua;

      # zellij
      ".config/zellij".source = ../../home/.config/zellij;

      # mise
      ".config/mise".source = ../../home/.config/mise;

      # tig
      ".tigrc".source = ../../home/.tigrc;

      # serena
      ".serena".source = ../../home/.serena;

      # karabiner
      ".config/karabiner".source = ../../home/.config/karabiner;

      # AeroSpace
      ".config/aerospace/aerospace.toml".source = ../../home/.config/aerospace/aerospace.toml;

      # Vimium
      ".config/vimium".source = ../../home/.config/vimium;

      # iTerm2 shell integration (also used by Cursor's terminal)
      ".iterm2_shell_integration.zsh".source = ../../home/.iterm2_shell_integration.zsh;

      # Claude Code
      ".claude/statusline.py".source = ../../home/.claude/statusline.py;
    };
  };
}
