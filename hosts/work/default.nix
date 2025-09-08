{ delib, ... }:
let
  isPrivate = false;
  common = import ../common.nix { inherit isPrivate; };
in
delib.host {
  name = "work";
  type = "desktop";

  inherit (common) myconfig;
}
