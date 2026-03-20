{
  isPrivate,
  privateApplications ? null,
  ...
}:
let
  hasNixSuffix = name: builtins.match ".*\\.nix" name != null;

  collectModuleFiles =
    dir:
    let
      entries = builtins.readDir dir;
    in
    builtins.filter (path: path != null) (
      map (
        name:
        let
          type = entries.${name};
          path = dir + "/${name}";
        in
        if type == "regular" && hasNixSuffix name then
          path
        else if type == "directory" && builtins.pathExists (path + "/default.nix") then
          path + "/default.nix"
        else
          null
      ) (builtins.attrNames entries)
    );

  moduleFiles = collectModuleFiles ../modules/programs ++ collectModuleFiles ../modules/homebrew;

  collectModuleNames =
    target:
    builtins.filter (name: name != null) (
      map (
        path:
        let
          match = builtins.match ".*name[[:space:]]*=[[:space:]]*\"([^\"]+)\"[[:space:]]*;.*" (
            builtins.readFile path
          );
          declared = if match == null then null else builtins.elemAt match 0;
          scoped = if declared == null then null else builtins.match "${target}\\.([^\"]+)" declared;
        in
        if scoped == null then null else builtins.elemAt scoped 0
      ) moduleFiles
    );

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
    "kustomize"
    "lazygit"
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
    "vscode"
    "wezterm"
    "zellij"
    "zoxide"
    "zsh"
  ];

  baseHomebrew = [
    "aerospace"
    "alt-tab"
    "aquaskk"
    "gas-mask"
    "google-chrome"
    "im-select"
    "karabiner"
    "rancher"
    "raycast"
  ];

  privateApplicationTargets = {
    ollama = "programs";
    zotero = "programs";
    lmstudio = "homebrew";
    lean = "programs";
    latex = "programs";
    tectonic = "programs";
    moonbit = "programs";
    ffmpeg = "programs";
    "brave-browser" = "homebrew";
    "1password" = "homebrew";
  };

  defaultPrivateApplications = builtins.attrNames privateApplicationTargets;

  moduleNamesByTarget = {
    programs = collectModuleNames "programs";
    homebrew = collectModuleNames "homebrew";
  };

  enabledPrivateApplications =
    if privateApplications != null then
      privateApplications
    else if isPrivate then
      defaultPrivateApplications
    else
      [ ];

  enabledModules = {
    programs =
      basePrograms
      ++ (builtins.filter (
        name: privateApplicationTargets.${name} == "programs"
      ) enabledPrivateApplications)
      ++ (if isPrivate then [ ] else [ "snyk" ]);

    homebrew =
      baseHomebrew
      ++ (builtins.filter (
        name: privateApplicationTargets.${name} == "homebrew"
      ) enabledPrivateApplications);
  };

  mkExplicitEnableAttrs =
    target: enabledNames:
    builtins.listToAttrs (
      map (name: {
        inherit name;
        value = {
          enable = builtins.elem name enabledNames;
        };
      }) moduleNamesByTarget.${target}
    );
in
{
  myconfig.host = {
    inherit isPrivate;
    privateApplications = enabledPrivateApplications;
  };

  myconfig = {
    programs = mkExplicitEnableAttrs "programs" enabledModules.programs;
    homebrew = mkExplicitEnableAttrs "homebrew" enabledModules.homebrew;
  };
}
