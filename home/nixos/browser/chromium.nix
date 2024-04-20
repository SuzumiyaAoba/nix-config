{ ... }:

{
  programs.chromium.commandLineArgs = [
    "--enable-features=UseOzonePlatform"
    "--ozone-platform=wayland"
  ];
}
