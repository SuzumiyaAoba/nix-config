{ delib, userConfig ? {}, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption (userConfig.username or (builtins.throw "user-config.username is required")));
    userfullname = readOnly (strOption (userConfig.userfullname or (builtins.throw "user-config.userfullname is required")));
    useremail = readOnly (strOption (userConfig.useremail or (builtins.throw "user-config.useremail is required")));
  };

  myconfig.always =
    { cfg, ... }:
    {
      args.shared.constants = cfg;
    };
}
