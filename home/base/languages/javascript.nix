{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # volta
    nodejs
    deno
    bun
    esbuild
  ];

  # home.sessionPath = [ "$HOME/.volta/bin" ];
}
