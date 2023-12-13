{ ... }:

{
  imports = [
    ./zellij
    ./starship.nix
    
    ./emacs

    ./git
    ./ghq.nix
    ./eza.nix
    ./bat.nix
    ./ripgrep.nix
  ];
}
