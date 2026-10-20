{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.emacs";
  options = delib.singleEnableOption false;

  darwin.ifEnabled.environment.systemPackages = [
    (pkgs.callPackage ../../pkgs/programs/emacs.nix {
      inherit pkgs;
      upstreamEmacs = inputs.emacs-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
    })
  ];
}
