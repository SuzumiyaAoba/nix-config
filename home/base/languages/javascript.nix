{ pkgs, ... }:

{
  home.packages = with pkgs; [
    volta
    deno
    bun
  ];
}
