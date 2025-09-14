{ isPrivate, ... }:
{
  myconfig.host.isPrivate = isPrivate;

  myconfig.programs = {
    ollama.enable = isPrivate;
    aider.enable = isPrivate;
    zed.enable = isPrivate;
    zotero.enable = isPrivate;
    lmstudio.enable = isPrivate;
    lean.enable = isPrivate;
  };
}
