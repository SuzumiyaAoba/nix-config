{ delib, pkgs, ... }:
delib.module {
  name = "programs.wezterm";

  options = delib.singleEnableOption true;

  home.ifEnabled =
    { myconfig, cfg, ... }:
    {
      programs.wezterm = {
        enable = true;
        # enableZshIntegration = true;

        extraConfig = ''
          local config = require 'config'

          -- 環境変数の設定
          config.set_environment_variables = {
            PATH = "/etc/profiles/per-user/${myconfig.constants.username}/bin:${pkgs.nix}/bin:" .. os.getenv("PATH"),
          }

          return config
        '';
      };
    };
}
