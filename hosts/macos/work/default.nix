{ ... }:

{
  imports = [
    ./configuration.nix
    ./homebrew.nix

    ./../../../modules/darwin/system.nix
    ./../../../modules/darwin/security.nix
  ];
}
