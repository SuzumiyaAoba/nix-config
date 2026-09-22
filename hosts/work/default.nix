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
}
