# nix-config

My Nix configuration.

## Commands

``` shell
nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --flake .#private
```

### format

``` shell
nix --extra-experimental-features nix-command --extra-experimental-features flakes fmt
```

