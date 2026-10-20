{ delib, lib, ... }:
delib.module {
  name = "features.personal";
  options = delib.singleEnableOption false;

  # Hosts can override individual tools with an ordinary enable assignment.
  myconfig.ifEnabled = {
    programs.ffmpeg.enable = lib.mkDefault true;
    programs.ollama.enable = lib.mkDefault true;
    programs.zotero.enable = lib.mkDefault true;
    homebrew."1password".enable = lib.mkDefault true;
    homebrew.brave-browser.enable = lib.mkDefault true;
    homebrew.lmstudio.enable = lib.mkDefault true;
  };
}
