#!/bin/sh

# Determinate Nix Installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

sudo -i nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
sudo -i nix-channel --update nixpkgs

# Clone nix-config repository
nix --experimental-features 'nix-command flakes' run nixpkgs#git -- clone https://github.com/SuzumiyaAoba/nix-config.git

cd nix-config

sudo rm -rf /etc/nix/nix.conf /etc/zshenv

# Install with cargo-mamke
# nix --experimental-features 'nix-command flakes' shell nixpkgs#cargo-make -c makers 'private-aarch64:apply'

