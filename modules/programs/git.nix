{ delib, lib, ... }:
delib.module {
  name = "programs.git";

  options = delib.singleEnableOption false;

  home.ifEnabled =
    { myconfig, ... }:
    {
      programs.git = {
        enable = true;
        lfs.enable = true;

        ignores = [
          "*~"
          "*.swp"
          ".DS_Store"
          ".dir-locals.el"
          ".env"
          ".playwright-cli/"
          ".claude/worktree/"
          "mise.local.toml"
          ".claude/settings.local.json"
          ".mise.local.toml"
        ];

        settings =
          let
            deltaOptions = [
              "core.pager=delta"
              "interactive.diffFilter='delta --color-only'"
              "delta.navigate=true"
              "delta.dark=true"
              "delta.line-numbers=true"
              "delta.side-by-side=true"
              "delta.hyperlinks=true"
              "delta.hyperlinks-file-link-format='vscode://file/{path}:{line}'"
            ];
          in
          {
            user = {
              name = myconfig.constants.username;
              email = myconfig.constants.useremail;
            };
            merge = {
              conflictStyle = "zdiff3";
            };
            alias = {
              delete-merged-branch = "!f() { base=\"$1\"; [ -n \"$base\" ] || base=HEAD; git for-each-ref --shell --merged=\"$base\" --format='branch=%(refname:short) worktree=%(worktreepath)' refs/heads | while read -r entry; do eval \"$entry\"; case \"$branch\" in \"$base\"|develop|main|master) continue ;; esac; [ -n \"$worktree\" ] && continue; git branch -d -- \"$branch\"; done; git fetch --prune; }; f";

              dlog = "-c diff.external=difft log --ext-diff";
              dl = "-c diff.external=difft log --ext-diff";
              dshow = "-c diff.external=difft show --ext-diff";
              ds = "-c diff.external=difft show --ext-diff";
              ddiff = "-c diff.external=difft diff";
              dft = "-c diff.external=difft diff";

              delta = "-c ${lib.concatStringsSep " -c " deltaOptions} diff";
              dblame = "-c ${lib.concatStringsSep " -c " deltaOptions} blame";
            };
          };
      };

      programs.diff-so-fancy = {
        enable = false;
      };

      programs.difftastic = {
        enable = false;
      };
    };
}
