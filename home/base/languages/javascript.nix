{ pkgs, ... }:

{
  home.packages = with pkgs; [
    volta
    deno
    bun
  ];

  home.sessionPath = [ "$HOME/.volta/bin" ];
}
