{ isPrivate, ... }:
{
  myconfig.host.isPrivate = isPrivate;

  myconfig = {
    programs = {
      ollama.enable = isPrivate;
      aider.enable = isPrivate;
      zed.enable = isPrivate;
      zotero.enable = isPrivate;
      lmstudio.enable = isPrivate;
      lean.enable = isPrivate;

      snyk.enable = !isPrivate;
    };

    homebrew = {
      brave-browser.enable = isPrivate;
      "1password".enable = isPrivate;
      lmstudio.enable = isPrivate;
    };
  };
}
