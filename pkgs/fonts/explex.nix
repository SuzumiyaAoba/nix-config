{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "explex";
  version = "0.0.3";

  src = fetchzip {
    url = "https://github.com/yuru7/Explex/releases/download/v${version}/Explex_v${version}.zip";
    hash = "sha256-OUmzF8GrwVgFAMSEiZLvh85nsOw1a0a7B70u2cRXXO8=";
  };

  installPhase = ''
    runHook preInstall

    find . -name '*.ttf' -exec install -Dt $out/share/fonts/truetype {} \;
    runHook postInstall
  '';

  meta = with lib; {
    description = "Explex は、0xProto と、IBM Plex Sans JP を合成した、プログラミング向けフォントです。";
    homepage = "https://github.com/yuru7/Explex";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
