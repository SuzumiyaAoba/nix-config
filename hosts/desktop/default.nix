{ delib, userConfig, ... }:
let
  isPrivate = true;
  common = import ../../lib/host-common.nix { inherit isPrivate; };
  inherit (common) myconfig;
in
delib.host {
  name = "desktop";
  type = "desktop";

  homeManagerUser = userConfig.homeManagerUser or userConfig.username;
  useHomeManagerModule = true;

  # shared attrs
  inherit myconfig;

  features = {
    session.enable = true;
    config.enable = true;

    macos.enable = true;
    homebrew.enable = true;
  };
}
