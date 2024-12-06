{ ... }:

{
  imports = [
    ./configuration.nix
    ./homebrew.nix

    ./../../../modules/darwin/system.nix
  ];
}
