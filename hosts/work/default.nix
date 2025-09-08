{ delib, ... }:
let
  isPrivate = false;
  common = import ../../lib/host-common.nix { inherit isPrivate; };
in
delib.host {
  name = "work";
  type = "desktop";

  inherit (common) myconfig;
  homeManagerUser = myconfig.constants.username;
}
