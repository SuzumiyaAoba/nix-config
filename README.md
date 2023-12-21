# nix-config

My Nix configuration.

## Commands

### for Private

```shell
nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --flake .#private --impure
```

### for Work

```shell
nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --flake .#work --impure
```

### format

``` shell
nix --extra-experimental-features nix-command --extra-experimental-features flakes fmt
```

