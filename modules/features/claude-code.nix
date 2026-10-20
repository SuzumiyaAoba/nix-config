{ delib, ... }:
delib.module {
  name = "features.claude-code";
  options = delib.singleEnableOption false;

  home.ifEnabled.home.file.".claude/statusline.py".source = ../../home/.claude/statusline.py;
}
