{ delib, ... }:
delib.module {
  name = "host";

  options =
    with delib;
    let
      applicationSet =
        { ... }:
        {
          options = {
            programs = listOfOption str [ ];
            homebrew = listOfOption str [ ];
          };
        };

      host =
        { config, ... }:
        {
          options = {
            isPrivate = boolOption false;
            privateApplications = submoduleOption applicationSet { };
            workApplications = submoduleOption applicationSet { };
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
