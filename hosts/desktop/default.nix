{ delib, ... }:
let
  isPrivate = true;
  common = import ../../lib/host-common.nix { inherit isPrivate; };
  inherit (common) myconfig;
in
delib.host {
  name = "desktop";
  type = "desktop";

  homeManagerUser = myconfig.constants.username;
  useHomeManagerModule = true;

  # shared attrs
  inherit myconfig;

  features.config.enable = true;
}
