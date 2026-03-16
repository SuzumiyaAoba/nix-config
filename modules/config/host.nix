{ delib, ... }:
delib.module {
  name = "host";

  options =
    with delib;
    let
      host =
        { config, ... }:
        {
          options = {
            isPrivate = boolOption false;
            privateApplications = listOfOption str [ ];
          };
        };
    in
    {
      host = hostOption host;
    };

  myconfig.always =
    { cfg, ... }:
    {
      args.shared.host = cfg.host;
    };
}
