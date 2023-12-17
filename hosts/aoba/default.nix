{ pkgs, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.aoba = {
    home = "/Users/aoba";
  };

  networking = { hostName = "aoba"; };
}
