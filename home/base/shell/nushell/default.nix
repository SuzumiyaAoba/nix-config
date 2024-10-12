{ config, pkgs, ... }:

{
  programs.nushell = {
    enable = false;

    configFile.source = ./config.nu;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
