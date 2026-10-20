{ delib, inputs, ... }:
delib.module {
  name = "packages";

  # Home Manager shares the system package set through useGlobalPkgs.
  darwin.always.nixpkgs.overlays = import ../../overlays { inherit inputs; };
}
