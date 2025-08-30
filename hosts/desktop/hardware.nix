{ delib, ... }:
delib.host {
  name = "desktop";

  system = "aarch64-darwin";

  homeManagerUser = "suzumiyaaoba";
  useHomeManagerModule = true;

  home.home.stateVersion = "25.05";

  # If you're not using NixOS, you can remove this entire block.
  # nixos = {
  #   system.stateVersion = "25.05";

  #   # nixos-generate-config --show-hardware-config
  #   # other generated code here...
  # };

  # If you're not using Nix-Darwin, you can remove this entire block.
  darwin = {
    system.stateVersion = 6;
  };
}
