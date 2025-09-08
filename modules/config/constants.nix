{ delib, userConfig ? {}, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption (userConfig.username or "suzumiyaaoba"));
    userfullname = readOnly (strOption (userConfig.userfullname or "SuzumiyaAoba"));
    useremail = readOnly (strOption (userConfig.useremail or "SuzumiyaAoba@gmail.com"));
  };

  myconfig.always =
    { cfg, ... }:
    {
      args.shared.constants = cfg;
    };
}
