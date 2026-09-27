{ delib, ... }:
delib.host {
  name = "desktop";

  system = "aarch64-darwin";

  # homeManagerUser / useHomeManagerModule are set in default.nix

  home.home.stateVersion = "25.05";

  darwin = {
    system.stateVersion = 6;
  };
}
