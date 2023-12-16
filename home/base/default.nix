{ ... }:

{
  imports = [
    ./shell
    ./terminal
    ./commands
    ./languages
    ./editor
    ./fonts.nix
  ];

  home = {
    sessionVariables = {
      EDITOR = "emacs";
    };
  };
}
