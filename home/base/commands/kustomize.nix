{ pkgs, ... }:

{
  # https://kustomize.io/
  home.packages = with pkgs; [
    kustomize
  ];
}
