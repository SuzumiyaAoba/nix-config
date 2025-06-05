# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build System and Commands

This repository uses `cargo-make` for task management. Common commands:

- **Apply configurations:**
  - `makers work:apply` - Apply work macOS configuration
  - `makers private-aarch64-256GB:apply` - Apply private 256GB macOS configuration  
  - `makers private-aarch64-1TB:apply` - Apply private 1TB macOS configuration
  - `makers nixos:apply` - Apply NixOS configuration

- **Maintenance:**
  - `makers format` or `nix fmt` - Format Nix files
  - `makers update` - Update flake inputs and git submodules
  - `makers gc` - Garbage collect old Nix store entries

## Architecture Overview

This is a multi-platform Nix configuration supporting both macOS (via nix-darwin) and NixOS systems. The structure follows a modular approach:

### Key Directories

- `flake.nix` - Main flake definition with system configurations
- `hosts/` - Host-specific configurations (macos/, nixos/)
- `home/` - Home Manager configurations organized by platform
- `modules/` - Reusable system-level modules
- `pkgs/` - Custom package definitions

### Configuration Structure

**Host Configurations:**
- Each host in `hosts/` imports its specific configuration, homebrew setup, and system modules
- Three macOS configs: work, private-aarch64-256GB, private-aarch64-1TB
- One NixOS config: nixos-x86_64

**Home Manager:**
- `home/base/` - Common home configuration shared across platforms
- `home/darwin/` - macOS-specific home configuration
- `home/nixos/` - NixOS-specific home configuration
- Organized by category: shell, terminal, commands, languages, editor, ide

**System Modules:**
- `modules/darwin/` - macOS system configuration modules
- `modules/nixos/` - NixOS system configuration modules
- Includes homebrew integration, security settings, system preferences

### Dependencies

Key flake inputs:
- `nixpkgs` - Main package repository
- `nix-darwin` - macOS system management
- `home-manager` - User environment management
- `nix-homebrew` - Homebrew integration for macOS
- `emacs-flake` - Custom Emacs configuration
- `hyprland` - Wayland compositor for NixOS
- Multiple homebrew tap inputs for macOS package management

### Username Convention

All configurations use the username `suzumiyaaoba` defined in the flake.

### Platform Support

- **macOS**: ARM64 (Apple Silicon) systems with homebrew integration
- **NixOS**: x86_64 systems with Wayland/Hyprland support