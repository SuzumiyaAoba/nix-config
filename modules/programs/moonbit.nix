{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.moonbit";
  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = [ pkgs.moonbit-bin.latest ];
}
