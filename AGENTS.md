# Repository Guidelines

## Project Structure & Module Organization
This repository manages macOS/Home Manager environments with Nix Flakes + Denix.

- `flake.nix`: entry point for inputs/outputs and configuration discovery.
- `hosts/`: host definitions (`desktop`, `work`) and hardware-specific settings.
- `modules/`: reusable modules by domain:
  - `modules/config/` for base user/home/host settings
  - `modules/features/` for higher-level feature toggles
  - `modules/programs/` for per-tool configuration
  - `modules/homebrew/` for Homebrew-managed apps
- `home/`: dotfiles linked into `$HOME` through Nix modules.
- `pkgs/`: custom package definitions.
- `user.example.nix`: template for local `user.nix`.

## Build, Test, and Development Commands
Use these commands from repository root:

- `nix flake check`: validate flake evaluation and checks.
- `nix flake show`: list available outputs/targets.
- `nix fmt`: format Nix files via `nixfmt` (treefmt wrapper).
- `nix build .#darwinConfigurations.desktop.system`: build desktop Darwin config.
- `nix build .#darwinConfigurations.work.system`: build work Darwin config.
- `sudo darwin-rebuild switch --flake .#desktop --override-input user-config path:./user.nix`: apply desktop config.
- `sudo darwin-rebuild switch --flake .#work --override-input user-config path:./user.nix`: apply work config.

If you use cargo-make, equivalent tasks are defined in `Makefile.toml` (e.g. `cargo make fmt`).

## Coding Style & Naming Conventions
- Use `nix fmt` before committing; do not hand-align formatting.
- Keep module files focused: one program/feature per file.
- File names use lowercase kebab-case (example: `claude-monitor.nix`).
- Prefer descriptive option names and small composable modules over large monoliths.

## Testing Guidelines
There is no separate unit test suite in this repo.
- Run `nix flake check` for baseline validation.
- Build affected targets (`nix build .#darwinConfigurations.<host>.system`) before PR.
- For module changes, verify both evaluation and switch behavior on the relevant host.

## Commit & Pull Request Guidelines
Follow the existing commit style from history:
- Prefix with lowercase type: `feat:`, `fix:`, `chore:`, `docs:`, `update:`.
- Keep subject concise and scoped (example: `fix: jetbrains`).

For pull requests:
- Include purpose, changed paths/modules, and impacted host(s) (`desktop`/`work`).
- List validation commands run and their results.
- Link related issues if available.

## Security & Configuration Tips
- Never commit secrets or personal identifiers in `user.nix`.
- Keep `user.example.nix` as the shareable template.
- Review `flake.lock` updates carefully; include them only when intentionally updating inputs.
