{
  isPrivate,
  privateApplications ? null,
  workApplications ? null,
  ...
}:
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

  defaultApplicationsByProfile = {
    private = {
      programs = [
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

      homebrew = [
        "lmstudio"
        "brave-browser"
        "1password"
        "codexbar"
        "zed"
      ];
    };

    work = {
      programs = [
        "snyk"
      ];

      homebrew = [ ];
    };
  };

  enabledApplicationsByProfile = {
    private =
      if privateApplications != null then
        privateApplications
      else if isPrivate then
        defaultApplicationsByProfile.private
      else
        {
          programs = [ ];
          homebrew = [ ];
        };

    work =
      if workApplications != null then
        workApplications
      else if isPrivate then
        {
          programs = [ ];
          homebrew = [ ];
        }
      else
        defaultApplicationsByProfile.work;
  };

  enabledApplicationsForTarget = profile: target: enabledApplicationsByProfile.${profile}.${target};

  enabledModules = {
    programs =
      basePrograms
      ++ (enabledApplicationsForTarget "private" "programs")
      ++ (enabledApplicationsForTarget "work" "programs");

    homebrew =
      baseHomebrew
      ++ (enabledApplicationsForTarget "private" "homebrew")
      ++ (enabledApplicationsForTarget "work" "homebrew");
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
