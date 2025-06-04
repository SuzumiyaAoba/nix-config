{ lib
, stdenvNoCC
}:
stdenvNoCC.mkDerivation rec {
  pname = "clive";
  version = "0.12.9";

  src = builtins.fetchTarball {
    url = "https://github.com/koki-develop/clive/releases/download/v${version}/clive_Darwin_arm64.tar.gz";
    sha256 = "1j5m9lq8qpj545fg5c86nlzvp1410f04apiy909grj9fpkzl0l63";
  };

  installPhase = ''
    mkdir -p $out/bin
    mv clive $out/bin
  '';

  meta = with lib; {
    description = "Automates terminal operations.";
    homepage = "https://github.com/koki-develop/clive/releases/tag/v0.12.9";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
