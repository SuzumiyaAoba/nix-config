{ delib, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "suzumiyaaoba");
    userfullname = readOnly (strOption "SuzumiyaAoba");
    useremail = readOnly (strOption "SuzumiyaAoba@gmail.com");
  };

  myconfig.always =
    { cfg, ... }:
    {
      args.shared.constants = cfg;
    };
}
