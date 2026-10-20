{ delib, lib, ... }:
delib.module {
  name = "features.research";
  options = delib.singleEnableOption false;

  # Hosts can override individual tools with an ordinary enable assignment.
  myconfig.ifEnabled = {
    programs.gauche.enable = lib.mkDefault true;
    programs.julia.enable = lib.mkDefault true;
    programs.latex.enable = lib.mkDefault true;
    programs.lean.enable = lib.mkDefault true;
    programs.moonbit.enable = lib.mkDefault true;
    programs.tectonic.enable = lib.mkDefault true;
  };
}
