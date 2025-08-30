{ delib, pkgs, ... }:
delib.module {
  name = "programs.tmux";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.tmux = {
      enable = true;

      prefix = "C-t";

      mouse = true;

      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_window_left_separator "█"
            set -g @catppuccin_window_right_separator "█ "
            set -g @catppuccin_window_number_position "right"
            set -g @catppuccin_window_middle_separator "  █"

            set -g @catppuccin_window_default_fill "number"

            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_current_text "#{pane_current_path}"

            set -g @catppuccin_status_modules_right "application session date_time"
            set -g @catppuccin_status_left_separator  ""
            set -g @catppuccin_status_right_separator " "
            set -g @catppuccin_status_fill "all"
            set -g @catppuccin_status_connect_separator "yes"
          '';
        }
        tmuxPlugins.pain-control
        tmuxPlugins.extrakto
        tmuxPlugins.fpp
        tmuxPlugins.fuzzback
        tmuxPlugins.fzf-tmux-url
        {
          plugin = tmuxPlugins.jump;
          extraConfig = ''
            set -g @jump-key 'J'
          '';
        }
        tmuxPlugins.open
        {
          plugin = tmuxPlugins.sensible;
          extraConfig = ''
            set -g default-shell "$SHELL"
            set -g default-command "$SHELL"
          '';
        }
        {
          plugin = tmuxPlugins.tilish;
          extraConfig = ''
            set -g @tilish-prefix 'M-space'
          '';
        }
        tmuxPlugins.tmux-fzf
        tmuxPlugins.tmux-thumbs
        # tmuxPlugins.power-theme
      ];
    };
  };
}
