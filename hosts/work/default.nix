{ delib, ... }:
let
  isPrivate = false;
  common = import ../../lib/host-common.nix { inherit isPrivate; };
  inherit (common) myconfig;
in
delib.host {
  name = "work";
  type = "desktop";

  inherit myconfig;
  homeManagerUser = myconfig.constants.username;
}
