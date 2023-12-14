{ ... }:

{
  imports = [
    ./zellij
    ./starship
    
    ./emacs

    ./git
    ./fzf
    ./ghq.nix
    ./eza.nix
    ./bat.nix
    ./ripgrep.nix

    ./volta.nix
    ./bun.nix
    ./deno.nix
  ];
}
