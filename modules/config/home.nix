{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "home";

  home.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      nix = {
        settings = {
          "experimental-features" = [
            "nix-command"
            "flakes"
          ];
        };
      };
      nixpkgs.overlays = [
        inputs.moonbit-overlay.overlays.default
      ];
      home = {
        inherit username;
        # If you don't need Nix-Darwin, or if you're using it exclusively,
        # you can keep the string here instead of the condition.
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
      };
    };
}
