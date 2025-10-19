# GEMINI.md

This file provides guidance to Gemini when working with code in this repository.

## Project Overview

This is a modular Nix configuration repository for `nix-darwin` and `home-manager`. It uses the [Denix](https://github.com/yunfachi/denix) framework to provide a unified and modular configuration system for different environments (e.g., personal desktop, work machine).

The configuration is built around Nix Flakes, with `flake.nix` as the central entry point. It manages system settings, home environment configurations, and applications for macOS.

### Key Technologies

*   **Nix:** The core package manager and language for declarative configuration.
*   **Nix Flakes:** Used for reproducible builds and dependency management.
*   **nix-darwin:** Allows for declarative management of macOS system configuration.
*   **home-manager:** Manages user-specific dotfiles and packages.
*   **Denix:** A framework that provides a modular structure for organizing Nix configurations.
*   **Homebrew:** Integrated into the Nix configuration to manage certain casks and packages.

### Architecture

*   `flake.nix`: The main entry point defining inputs (dependencies) and outputs (system and home configurations).
*   `hosts/`: Contains host-specific configurations (e.g., `desktop`, `work`). Each host can enable a different set of features.
*   `modules/`: The core of the configuration, organized into subdirectories:
    *   `config/`: Base configuration for users, hosts, and home.
    *   `features/`: High-level feature groups (e.g., fonts, macOS settings, Homebrew).
    *   `programs/`: Configurations for individual applications.
    *   `homebrew/`: Nix modules for Homebrew casks.
*   `home/`: Contains static dotfiles that are symlinked into the user's home directory by `home-manager`.
*   `lib/`: Shared Nix functions and common configurations.
*   `user.example.nix`: A template for user-specific information like username and email. This should be copied to `user.nix` for local configuration.

## Building and Running

The project uses standard Nix commands.

### Common Commands

*   **Check Configuration:** Validate the entire flake for errors.
    ```bash
    nix flake check
    ```
*   **Format Code:** Format all Nix files using `nixfmt`.
    ```bash
    nix fmt
    ```
*   **Build a System Configuration:** Build the complete `nix-darwin` system configuration for a specific host.
    ```bash
    # Replace <hostname> with a host defined in the `hosts` directory (e.g., desktop)
    nix build .#darwinConfigurations.<hostname>.system
    ```
*   **Apply System Configuration:** Build and activate the `nix-darwin` configuration.
    ```bash
    # Replace <hostname> with your target host
    darwin-rebuild switch --flake .#<hostname>
    ```
*   **Apply Home Manager Configuration:** Build and activate the `home-manager` configuration for a user.
    ```bash
    # Replace <username> with the username defined in your user.nix
    home-manager switch --flake .#<username>
    ```

## Development Conventions

### Adding a New Program

1.  Create a new Nix module in `modules/programs/<program-name>.nix`.
2.  The module should define an `options` set with an `enable` flag and a `config` set to configure the program when enabled.
3.  Add the new program module to a relevant feature in the `modules/features/` directory or directly to a host configuration in `hosts/`.

### User-Specific Configuration

*   To apply a personal configuration, copy `user.example.nix` to `user.nix` and fill in your details (username, email, etc.). This file is git-ignored and allows for local overrides without modifying tracked files.

### Environment-Specific Features

*   The configurations in `hosts/` use a `isPrivate` flag in `lib/host-common.nix` to conditionally enable or disable certain features. For example, personal tools and AI assistants are only enabled on the `desktop` host, where `isPrivate = true`. This allows for a clean separation between personal and work environments.
