{ hyprland, hyprland-plugins, hy3, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = false;

    systemd.variables = [ "--all" ];

    plugins = [
      # hyprland-plugins.packages.${pkgs.system}.hyprbars
      # hy3.packages.${pkgs.system}.hy3
    ];

    settings = {
      "$mod" = "SUPER";

      bind =
        [
          "$mod, RETURN, exec, kitty"
          "$mod, d, exec, wofi -f -S run -i"
          "$mod_SHIFT, Q, killactive"
          ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };
}
