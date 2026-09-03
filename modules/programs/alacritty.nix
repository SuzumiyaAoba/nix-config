{ delib, pkgs, ... }:
delib.module {
  name = "programs.alacritty";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.alacritty = {
      enable = true;

      settings = {
        font = {
          normal.family = "HackGen Console NF";
          size = 14;
        };

        terminal.shell.program = "${pkgs.zellij}/bin/zellij";

        keyboard.bindings = [
          {
            key = "J";
            mods = "Control";
            action = "None";
          }
        ];
      };
    };
  };
}
