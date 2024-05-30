{ pkgs, ... }:

let
  wofi = "${pkgs.wofi}/bin/wofi";
in
{
  wayland.windowManager.sway = {
    enable = false;
    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      bars = [
        {
          command = "waybar";
        }
      ];
      menu = "${wofi} -f -S run -i";
      output = {
        "Eizo Nanao Corporation EV2785 0x03080071" = {
          scale =  "2";
        };
      };
      input = {
        "1133:16505:Logitech_G_Pro" = {
          pointer_accel = "-0.5";
        };
      };

      gaps = {
        bottom = 16;
        horizontal = 10;
        vertical = 10;
        inner = 10;
        left = 10;
        outer = 10;
        right = 10;
        top = 10;
        smartBorders = "on";
        smartGaps = true;
      };
    };
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
}
