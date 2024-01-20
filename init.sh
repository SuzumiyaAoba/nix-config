#!/bin/sh

# Determinate Nix Installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 

# Clone nix-config repository
nix run nixpkgs#git -- clone https://github.com/SuzumiyaAoba/nix-config.git

cd nix-config

# Install with cargo-mamke
nix --experimental-features 'nix-command flakes' shell nixpkgs#cargo-make -c makers 'private-aarch64:apply'
