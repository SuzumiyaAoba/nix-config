{ ... }:

{
  home = {
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "emacs";
    };
  };

  programs.home-manager.enable = true;

  imports = [
    ./shell
    ./terminal
    ./commands
    ./languages
    ./editor
    ./ide
    ./fonts.nix
  ];
}
