{ delib, pkgs, ... }:
delib.module {
  name = "programs.tmux";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.tmux = {
      enable = true;

      prefix = "C-t";

      mouse = true;

      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = catppuccin;
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
        pain-control
        extrakto
        fpp
        fuzzback
        fzf-tmux-url
        {
          plugin = jump;
          extraConfig = ''
            set -g @jump-key 'J'
          '';
        }
        open
        {
          plugin = sensible;
          extraConfig = ''
            set -g default-shell "$SHELL"
            set -g default-command "$SHELL"
          '';
        }
        {
          plugin = tilish;
          extraConfig = ''
            set -g @tilish-prefix 'M-space'
          '';
        }
        tmux-fzf
        tmux-thumbs
        # power-theme
      ];
    };
  };
}
