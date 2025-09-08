{ isPrivate }:
{
  myconfig.host.isPrivate = isPrivate;
  myconfig.programs.ollama.enable = isPrivate;
}


