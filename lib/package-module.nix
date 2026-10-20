# Use this only for tools that need installation without additional configuration.
{
  delib,
  name,
  package,
}:
delib.module {
  inherit name;
  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = [ package ];
}
