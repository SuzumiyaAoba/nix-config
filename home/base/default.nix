{ ... }:

{
  imports = [
    ./shell
    ./terminal
    ./commands
    ./programs
    ./fonts.nix
  ];

  home = {
    sessionVariables = {
      EDITOR = "emacs";
    };
  };
}
