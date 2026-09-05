{ delib, pkgs, ... }:
delib.module {
  name = "programs.wezterm";

  options = delib.singleEnableOption false;

  home.ifEnabled =
    { myconfig, ... }:
    {
      programs.wezterm = {
        enable = true;
        # enableZshIntegration = true;

        extraConfig = ''
          local config = require 'config'

          -- 環境変数の設定
          config.set_environment_variables = {
            PATH = "/etc/profiles/per-user/${myconfig.constants.username}/bin:" .. os.getenv("HOME") .. "/.nix-profile/bin:${pkgs.nix}/bin:" .. os.getenv("PATH"),
          }

          -- default_prog の zellij は home-manager profile 由来で
          -- 上記 PATH に含まれない場合があるため絶対パスで固定する
          config.default_prog = { "${pkgs.zellij}/bin/zellij" }

          return config
        '';
      };
    };
}
