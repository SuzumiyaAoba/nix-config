# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modular Nix configuration repository for NixOS, Home Manager, and Nix-Darwin using the Denix framework. It provides a unified configuration system for different environments (desktop/work) with feature toggles and modular components.

## Common Development Commands

### Building and Testing
- `nix flake check` - Validate the flake configuration
- `nix flake show` - Display available configurations and outputs
- `nix fmt` - Format Nix files using nixfmt (configured via treefmt-nix)
- `nix build .#darwinConfigurations.<hostname>.system` - Build Darwin system configuration
- `nix build .#homeConfigurations.<username>` - Build Home Manager configuration

### Deployment
- `darwin-rebuild switch --flake .#<hostname>` - Apply Darwin system configuration
- `home-manager switch --flake .#<username>` - Apply Home Manager configuration
- `nix run nix-darwin -- switch --flake .#<hostname>` - Alternative Darwin deployment method

### Development Workflow
- Copy `user.example.nix` to `user.nix` with your personal configuration
- Modify host configurations in `hosts/desktop/` or `hosts/work/`
- Add new features in `modules/features/`
- Add program configurations in `modules/programs/`

## Architecture

### Core Structure
- **flake.nix**: Main entry point defining inputs, outputs, and system configurations
- **user.nix**: Personal user configuration (copied from user.example.nix)
- **hosts/**: Host-specific configurations (desktop, work)
- **modules/**: Modular system components organized by purpose
- **home/**: Static configuration files that get symlinked to home directory
- **lib/**: Shared library functions and host-common configurations

### Host Configuration System
Host configurations use the Denix framework with a common structure:
- Each host imports `lib/host-common.nix` which sets feature availability based on `isPrivate` flag
- Desktop host (`isPrivate = true`) enables personal tools like Ollama, Aider, Zed, Zotero, LM Studio
- Work host (`isPrivate = false`) disables these personal/AI tools for professional environments
- Both configurations enable core features: session management, config files, macOS integration, and Homebrew

### Module Organization
- **modules/config/**: Core system configuration (user, home, host settings)
- **modules/features/**: High-level feature modules (fonts, homebrew, macOS, session)
- **modules/programs/**: Individual program configurations
- **modules/homebrew/**: Homebrew-specific package configurations

### Configuration Flow
1. `flake.nix` defines system using Denix configurations with paths `./hosts` and `./modules`
2. Denix automatically discovers and imports all modules from these directories
3. Host configurations in `hosts/` specify which features to enable
4. Feature modules conditionally include program modules and configurations
5. `modules/features/config.nix` handles dotfile symlinking from `home/` directory

### Key Features
- **Modular Design**: Each program/feature is a separate module that can be enabled/disabled
- **Environment-Aware**: Different configurations for private (desktop) vs work environments  
- **Dotfile Management**: Static config files stored in `home/` and symlinked via Nix
- **Multi-System Support**: Supports both Darwin (macOS) and Home Manager configurations
- **Homebrew Integration**: Nix-managed Homebrew with custom package modules

## User Configuration

The `user.nix` file should contain:
```nix
{
  username = "your-username";
  userfullname = "Your Full Name";
  useremail = "your@email.com";
}
```

## Adding New Components

### New Program Module
1. Create `modules/programs/<program>.nix`
2. Use `delib.module` structure with enable option
3. Add program-specific configuration in conditional blocks
4. Reference it in relevant feature modules or host configurations

### New Feature Module  
1. Create `modules/features/<feature>.nix`
2. Define feature-level enable option
3. Conditionally enable related program modules
4. Add to host configuration feature lists

### Static Configuration Files
1. Add files to `home/.config/<program>/` directory
2. Reference in `modules/features/config.nix` file mapping
3. Files are automatically symlinked to user's home directory

## Troubleshooting

- Check flake inputs are up to date: `nix flake update`
- Validate syntax: `nix flake check`
- Debug module loading: Check `nix flake show` output for available configurations
- For permission issues: Ensure user has appropriate access to `/nix/store` and system directories
- Home Manager conflicts: Clear existing dotfiles that conflict with managed ones