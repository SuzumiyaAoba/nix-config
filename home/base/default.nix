{ ... }:

{
  imports = [
    ./shell
    ./terminal
    ./commands
    ./languages
    ./editor
    ./ide
    ./fonts.nix
  ];

  home = {
    sessionVariables = {
      EDITOR = "emacs";
    };
  };
}
