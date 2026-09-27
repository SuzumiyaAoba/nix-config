{ delib, ... }:
delib.module {
  name = "user";

  # If you're not using Nix-Darwin, you can remove this entire block.
  darwin.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      users.users.${username} = {
        name = username;
        home = "/Users/${username}";
      };
    };
}
