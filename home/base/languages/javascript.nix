{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # volta
    deno
    bun
    esbuild
  ];

  # home.sessionPath = [ "$HOME/.volta/bin" ];
}
