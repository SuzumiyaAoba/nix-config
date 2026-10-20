{ delib, lib, ... }:
delib.module {
  name = "features.work";
  options = delib.singleEnableOption false;

  # Hosts can override individual tools with an ordinary enable assignment.
  myconfig.ifEnabled = {
    programs.snyk.enable = lib.mkDefault true;
  };
}
