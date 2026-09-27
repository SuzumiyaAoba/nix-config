{ isPrivate, ... }:
let
  basePrograms = [
    "alacritty"
    "appcleaner"
    "ast-grep"
    "atuin"
    "bat"
    "bottom"
    "carapace"
    "cargo-make"
    "clive"
    "cmake"
    "cmigemo"
    "coreutils"
    "delta"
    "difftastic"
    "ditaa"
    "duckdb"
    "emacs"
    "emacs-lsp-booster"
    "eza"
    "fd"
    "fzf"
    "fzy"
    "gcc"
    "gh"
    "gh-dash"
    "ghq"
    "git"
    "glab"
    "global"
    "glow"
    "gnupg"
    "hexyl"
    "hurl"
    "imagemagic"
    "iterm"
    "java"
    "jd-diff-patch"
    "jetbrains"
    "jq"
    "karabiner"
    "kustomize"
    "lazygit"
    "leaf"
    "lua"
    "mise"
    "mkcert"
    "mysql"
    "neovim"
    "nushell"
    "oracle"
    "pandoc"
    "powerlevel10k"
    "rectangle"
    "ripgrep"
    "rust"
    "sd"
    "tbls"
    "tig"
    "tokei"
    "tree"
    "uv"
    "vhs"
    "wezterm"
    "zellij"
    "zoxide"
    "zsh"
  ];

  baseHomebrew = [
    # "aerospace"
    # "alt-tab"
    "aquaskk"
    "gas-mask"
    "google-chrome"
    "intellij-idea"
    "rancher"
    "raycast"
    "rtk"
    "tgrep"
    "vscode"
  ];

  privatePrograms = [
    "gauche"
    "ollama"
    "zotero"
    "julia"
    "lean"
    "latex"
    "tectonic"
    "moonbit"
    "ffmpeg"
  ];

  privateHomebrew = [
    "lmstudio"
    "brave-browser"
    "1password"
    "codexbar"
    "zed"
  ];

  workPrograms = [ "snyk" ];

  workHomebrew = [ ];

  enabledModules =
    if isPrivate then
      {
        programs = basePrograms ++ privatePrograms;
        homebrew = baseHomebrew ++ privateHomebrew;
      }
    else
      {
        programs = basePrograms ++ workPrograms;
        homebrew = baseHomebrew ++ workHomebrew;
      };

  # Every module under modules/programs and modules/homebrew declares
  # `delib.singleEnableOption false`, so only the enabled ones need
  # `enable = true` here. Unknown names fail at evaluation time.
  mkEnableAttrs =
    names:
    builtins.listToAttrs (
      map (name: {
        inherit name;
        value.enable = true;
      }) names
    );
in
{
  myconfig = {
    programs = mkEnableAttrs enabledModules.programs;
    homebrew = mkEnableAttrs enabledModules.homebrew;
  };
}
