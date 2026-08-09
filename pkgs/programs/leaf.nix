{
  lib,
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation rec {
  pname = "leaf";
  version = "1.27.0";

  src = fetchurl {
    url = "https://github.com/RivoLink/leaf/releases/download/${version}/leaf-macos-arm64";
    hash = "sha256-q+B/PZVZlsR7qX12e9jFwsT9A2W8883En46sYkVFcU0=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 $src $out/bin/leaf

    runHook postInstall
  '';

  meta = with lib; {
    description = "Terminal Markdown previewer with a GUI-like experience";
    homepage = "https://github.com/RivoLink/leaf";
    license = licenses.mit;
    mainProgram = "leaf";
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
