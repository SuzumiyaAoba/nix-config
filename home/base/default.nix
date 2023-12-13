{ ... }:

{
  imports = [
    ./shell
    ./terminal
    ./programs
  ];

  home = {
    sessionVariables = {
      EDITOR = "emacs";
    };
  };
}
