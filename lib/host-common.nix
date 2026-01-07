{ isPrivate, ... }:
{
  myconfig.host.isPrivate = isPrivate;

  myconfig = {
    programs = {
      ollama.enable = false;
      aider.enable = false;
      zed.enable = isPrivate;
      zotero.enable = isPrivate;
      lmstudio.enable = isPrivate;
      lean.enable = isPrivate;
      latex.enable = isPrivate;
      tectonic.enable = isPrivate;
      moonbit.enable = isPrivate;

      snyk.enable = !isPrivate;
    };

    homebrew = {
      brave-browser.enable = isPrivate;
      "1password".enable = isPrivate;
      lmstudio.enable = isPrivate;
    };
  };
}
