{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
                    ${pkgs.greetd.tuigreet}/bin/tuigreet \
          	          --time \
          	          --asterisks \
          	          --user-menu \
          	          --cmd sway
        '';

        user = "suzumiyaaoba";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
}
