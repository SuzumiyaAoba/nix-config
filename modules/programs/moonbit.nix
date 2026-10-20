{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.moonbit";
  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = [
    (pkgs.callPackage ../../pkgs/programs/moonbit.nix {
      inherit pkgs;
      overlaySrc = inputs.moonbit-overlay;
    })
  ];
}
