{ delib, ... }:
delib.module {
  name = "host";

  options = with delib; let
    host = { config, ... }: {
      options = {
        isPrivate = boolOption false;
      };
    };
  in {
    host = hostOption host;
  };

  myconfig.always = { cfg, ... }: {
    args.shared.host = cfg.host;
  };
}
