{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
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
      terminal = "wezterm";
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
