{ ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = [ "sway/workspaces" ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "cpu"
          "memory"
          "clock"
          "tray"
        ];

        clock.format = "{:%Y-%m-%d %H:%M}";
        "tray" = { spacing = 8; };
        "cpu" = { fromat = "CPU {usage}%"; };
        "memory" = { format = "Memory {used:0.1f}G"; };
      };
    };

    style = ''
      @define-color background-darker rgba(30, 31, 41, 230);
      @define-color background #282a36;
      @define-color selection #44475a;
      @define-color foreground #f8f8f2;
      @define-color comment #6272a4;
      @define-color cyan #8be9fd;
      @define-color green #50fa7b;
      @define-color orange #ffb86c;
      @define-color pink #ff79c6;
      @define-color purple #bd93f9;
      @define-color red #ff5555;
      @define-color yellow #f1fa8c;

      * {
        font-family: 'HackGen Console NF';
        border: none;
        border-radius: 0;
        font-size: 14pt;
        min-height: 0;
        padding: 2px 0;
      }
      window#waybar {
        opacity: 0.9;
        background: @background-darker;
        color: @foreground;
        border-bottom: 2px solid @background;
      }
      #workspaces button {
        padding: 0 10px;
        margin: 0 2px;
        background: @background;
        color: @foreground;
      }
      #workspaces button.focused {
        background: @red;
        border-radius: 10px;
      }
      #clock {
        padding: 0 4px;
        background: @background;
      }
    '';
  };
}
