{
  lib,
  stdenvNoCC,
  fetchzip,
}:
# nixpkgs' udev-gothic is older; fetch the upstream prebuilt release instead
# of building from source (fontforge + python) like the previous version did.
stdenvNoCC.mkDerivation rec {
  pname = "udev-gothic";
  version = "2.2.0";

  src = fetchzip {
    url = "https://github.com/yuru7/udev-gothic/releases/download/v${version}/UDEVGothic_v${version}.zip";
    hash = "sha256-x6nM35UM7v4WQn6DINuEgXQmSQ4ysPS4omY9ePDTAhA=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "Programming font that combines BIZ UD Gothic and JetBrains Mono";
    homepage = "https://github.com/yuru7/udev-gothic";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
