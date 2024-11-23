{ pkgs,
  lib,
  stdenvNoCC,
  fetchFromGitHub
}:
stdenvNoCC.mkDerivation rec {
  pname = "keg";

  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "conao3";
    repo = "keg.el";
    rev = "cbdc1c48536ccc68aa6d9a2737d55c99d602650f";
    sha256 = "1v535sikl3i4jx9hykyas1nqa449bzmcybn7h2l695imgifxiqy0";
  };

  runtimeDependencies = with pkgs; [
    emacs
  ];

  installPhase = ''
    mkdir -p $out
    mv * $out
  '';

  meta = with lib; {
    description = "Modern Elisp package development system";
    homepage = "https://github.com/conao3/keg.el";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
