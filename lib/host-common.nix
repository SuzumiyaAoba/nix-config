{ isPrivate, ... }:
{
  myconfig.host.isPrivate = isPrivate;
  myconfig.programs.ollama.enable = isPrivate;
  myconfig.programs.aider.enable = isPrivate;
  myconfig.programs.zed.enable = isPrivate;
  myconfig.programs.zotero.enable = isPrivate;
  myconfig.programs.lmstudio.enable = isPrivate;
}

