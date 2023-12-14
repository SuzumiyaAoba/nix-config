{ ... }:

{
  imports = [
    ./zellij
    ./starship
    
    ./emacs
    ./vscode

    ./git
    ./fzf
    ./ghq.nix
    ./eza.nix
    ./bat.nix
    ./ripgrep.nix
    ./fd.nix
    ./bottom.nix
    ./jq.nix
    ./xsv.nix
    ./csview.nix
    ./tig

    ./languages
  ];
}
