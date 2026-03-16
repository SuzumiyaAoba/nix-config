{
  isPrivate,
  privateApplications ? null,
  ...
}:
let
  privateApplicationTargets = {
    ollama = "programs";
    zotero = "programs";
    lmstudio = "homebrew";
    lean = "programs";
    latex = "programs";
    tectonic = "programs";
    moonbit = "programs";
    ffmpeg = "programs";
    "brave-browser" = "homebrew";
    "1password" = "homebrew";
  };

  defaultPrivateApplications = builtins.attrNames privateApplicationTargets;

  enabledPrivateApplications =
    if privateApplications != null then
      privateApplications
    else if isPrivate then
      defaultPrivateApplications
    else
      [ ];

  mkEnabledAttrs =
    target:
    builtins.listToAttrs (
      map (name: {
        inherit name;
        value = {
          enable = builtins.elem name enabledPrivateApplications;
        };
      }) (builtins.filter (name: privateApplicationTargets.${name} == target) defaultPrivateApplications)
    );
in
{
  myconfig.host = {
    inherit isPrivate;
    privateApplications = enabledPrivateApplications;
  };

  myconfig = {
    programs = (mkEnabledAttrs "programs") // {
      aider.enable = false;
      snyk.enable = !isPrivate;
    };

    homebrew = mkEnabledAttrs "homebrew";
  };
}
