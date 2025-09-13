{ delib, userConfig, ... }:
let
  isPrivate = false;
  common = import ../../lib/host-common.nix { inherit isPrivate; };
  inherit (common) myconfig;
in
delib.host {
  name = "work";
  type = "desktop";

  homeManagerUser = userConfig.username;
  useHomeManagerModule = true;

  inherit myconfig;

  features = {
    session.enable = true;
    config.enable = true;

    macos.enable = true;
    homebrew.enable = true;
  };
}
