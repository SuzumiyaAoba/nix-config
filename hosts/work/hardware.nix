{ delib, ... }:
delib.host {
  name = "work";
  system = "aarch64-darwin";

  # homeManagerUser is set in default.nix
  useHomeManagerModule = true;

  home.home.stateVersion = "25.05";

  darwin = {
    system.stateVersion = 6;
  };
}
