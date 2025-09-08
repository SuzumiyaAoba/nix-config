{ delib, ... }:
let
  isPrivate = true;
  common = import ../../lib/host-common.nix { inherit isPrivate; };
in
delib.host {
  name = "desktop";
  type = "desktop";

  homeManagerUser = "suzumiyaaoba";
  useHomeManagerModule = true;

  # shared attrs
  inherit (common) myconfig;

  features.config.enable = true;
}
