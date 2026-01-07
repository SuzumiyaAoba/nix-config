{
  delib,
  inputs,
  pkgs,
  ...
}:
let
  overlaySrc = inputs.moonbit-overlay;
  pkgsForMoon = pkgs.extend (
    final: prev: {
      tinycc = prev.tinycc.overrideAttrs (old: {
        meta = (old.meta or { }) // { broken = false; };
      });
    }
  );
  versionsRaw = import "${overlaySrc}/versions.nix" pkgs.lib;
  pinnedVersion = versionsRaw.latest.version;
  pinnedRecord = versionsRaw.${pinnedVersion};
  moonbitBinPinned = import "${overlaySrc}/lib/moonbit-bin.nix" {
    lib = pkgs.lib;
    pkgs = pkgsForMoon;
    versions = {
      pinned = pinnedRecord;
    };
    minVersion = "0.6.28";
  };
  toolchainsPinned =
    moonbitBinPinned.legacyPackages.toolchains.pinned.overrideAttrs (old: {
      # Keep the bundled tcc (no tinycc dependency), but keep moon-patched.
      installPhase = ''
        runHook preInstall

        mkdir -p $out
        cp -a ./* $out/
        chmod +x $out/bin/*
        chmod +x $out/bin/internal/tcc

        cp ${moonbitBinPinned.legacyPackages."moon-patched".pinned}/bin/moon $out/bin/moon
        cp ${moonbitBinPinned.legacyPackages."moon-patched".pinned}/bin/moonrun $out/bin/moonrun

        runHook postInstall
      '';
    });
  corePinned = moonbitBinPinned.legacyPackages.core.pinned;
  moonbitPinned = pkgsForMoon.callPackage "${overlaySrc}/lib/bundle.nix" {
    toolchains = toolchainsPinned;
    core = corePinned;
  };
in
delib.module {
  name = "programs.moonbit";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      moonbitPinned
    ];
  };
}
