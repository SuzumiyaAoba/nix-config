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
          pointer_accel = "-1";
        };
      };
      terminal = "wezterm";
    };
  };
}
