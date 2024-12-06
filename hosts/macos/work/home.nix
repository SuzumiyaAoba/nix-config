{ pkgs, config, username, ... }:
let
  baseDir = ../../..;
in
{
  home = {
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "emacs";
      COLORTERM = "truecolor";
    };
  };

  programs.home-manager.enable = true;

  imports = builtins.map (f: baseDir + "/${f}") [
    # GUI
    "home/darwin/base/gui/karabiner"
    "home/darwin/base/gui/raycast.nix"
    "home/darwin/base/gui/rectangle.nix"
    "home/programs/editor/vscode"

    # Editors
    "home/programs/editor/emacs"

    # IDE
    "home/programs/ide/jetbrains.nix"

    # fonts
    "home/base/fonts.nix"

    # terminal & shell
    "home/programs/terminal/wezterm"
    "home/programs/shell/zsh"
    "home/programs/shell/starship"
    "home/programs/shell/tmux.nix"

    # languages
    "home/base/languages/java.nix"
    "home/base/languages/javascript.nix"

    # commands
    "home/programs/commands/ast-grep.nix"
    "home/programs/commands/atuin.nix"
    "home/programs/commands/bat.nix"
    "home/programs/commands/cargo-make.nix"
    "home/programs/commands/coreutils.nix"
    "home/programs/commands/delta.nix"
    "home/programs/commands/eza.nix"
    "home/programs/commands/fd.nix"
    "home/programs/commands/fzf"
    "home/programs/commands/tree.nix"
    "home/programs/commands/ghq.nix"
    "home/programs/commands/git"
    "home/programs/commands/jq.nix"
    "home/programs/commands/ripgrep.nix"
    "home/programs/commands/sd.nix"
    "home/programs/commands/sheldon"
    "home/programs/commands/timewarrior.nix"
    "home/programs/commands/taskwarrior.nix"
  ];
}
