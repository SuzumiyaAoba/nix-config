{ delib, ... }:
delib.module {
  name = "host";

  options = with delib; {
    host = {
      isPrivate = boolOption false;
      enableOllama = boolOption false;
    };
  };

  myconfig.always = { cfg, ... }: {
    args.shared.host = cfg.host;
  };
}
