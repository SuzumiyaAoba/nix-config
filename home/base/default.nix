{ ... }:

{
  imports = [
    ./shell
    ./terminal
    ./programs
    ./fonts.nix
  ];

  home = {
    sessionVariables = {
      EDITOR = "emacs";
    };
  };
}
