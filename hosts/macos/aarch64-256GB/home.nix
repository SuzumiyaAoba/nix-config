{ pkgs, config, username, ... }:
let
  baseDir = ../../..;
in
{
  home = {
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "emacs";
    };
  };

  programs.home-manager.enable = true;

  # Workaround for "unable to download 'https://git.sr.ht/~rycee": https://github.com/nix-community/home-manager/issues/4879#issuecomment-1884851745
  manual = {
    html.enable = false;
    manpages.enable = false;
    json.enable = false;
  };
  
  imports = builtins.map (f: baseDir + "/${f}") [
    # GUI
    "home/darwin/base/gui/appcleaner.nix"
    "home/darwin/base/gui/karabiner"
    "home/darwin/base/gui/raycast.nix"
    "home/darwin/base/gui/rectangle.nix"
    "home/darwin/base/gui/terminal-notifier.nix"
    "home/base/editor/vscode"

    # Editors
    "home/darwin/base/editor/emacs.nix"
    "home/base/editor/emacs"

    # IDE
    "home/base/ide/jetbrains.nix"

    # fonts
    "home/base/fonts.nix"

    # terminal & shell
    "home/base/terminal/wezterm"
    "home/base/shell/zsh"
    "home/base/shell/starship"
    "home/base/shell/tmux.nix"

    # languages
    "home/base/languages/clojure.nix"
    "home/base/languages/go.nix"
    "home/base/languages/java.nix"
    "home/base/languages/javascript.nix"
    "home/base/languages/rust.nix"

    # commands
    "home/base/commands/ast-grep.nix"
    "home/base/commands/atuin.nix"
    "home/base/commands/bat.nix"
    "home/base/commands/cargo-make.nix"
    "home/base/commands/coreutils.nix"
    "home/base/commands/delta.nix"
    "home/base/commands/eza.nix"
    "home/base/commands/fd.nix"
    "home/base/commands/fzf"
    "home/base/commands/ghq.nix"
    "home/base/commands/git"
    "home/base/commands/jq.nix"
    "home/base/commands/ripgrep.nix"
    "home/base/commands/sd.nix"
    "home/base/commands/sheldon"
    "home/base/commands/tbls.nix"
  ];
}
