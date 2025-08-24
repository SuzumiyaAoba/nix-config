{ delib, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    #!!! REPLACEME
    username = readOnly (strOption "suzumiyaaoba");
    userfullname = readOnly (strOption "SuzumiyaAoba");
    useremail = readOnly (strOption "SuzumiyaAoba@gmail.com");
  };
}
