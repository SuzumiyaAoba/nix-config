{
  lib,
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation rec {
  pname = "cascadia-next";
  version = "cascadia-next";

  src = fetchurl {
    url = "https://github.com/microsoft/cascadia-code/releases/download/cascadia-next/CascadiaNextJP.wght.ttf";
    hash = "sha256-r4v57pjisJ03YGa7lx29hK5rsJhCft/oDV1l7+ECRc8=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 $src $out/share/fonts/truetype/CascadiaNextJP.wght.ttf

    runHook postInstall
  '';

  meta = with lib; {
    description = "This is a fun, new monospaced font that includes programming ligatures and is designed to enhance the modern look and feel of the Windows Terminal.";
    homepage = "https://github.com/microsoft/cascadia-code/releases/tag/cascadia-next";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
