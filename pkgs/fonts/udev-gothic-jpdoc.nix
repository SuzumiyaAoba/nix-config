{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  fontforge,
  python3,
}:
let
  pythonEnv = python3.withPackages (
    ps: with ps; [
      fonttools
      ttfautohint-py
    ]
  );
in
stdenvNoCC.mkDerivation rec {
  pname = "udev-gothic-jpdoc";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "yuru7";
    repo = "udev-gothic";
    rev = "v${version}";
    hash = "sha256-Rpg58krE0DoJig3dWO1O+VYazh2J2lzBE9Q6gLh1/rw=";
  };

  nativeBuildInputs = [
    fontforge
    pythonEnv
  ];

  buildPhase = ''
        runHook preBuild

        python - <<'PY'
    from pathlib import Path

    path = Path("fonttools_script.py")
    output = []
    for line in path.read_text().splitlines():
        stripped = line.strip()
        if line == "import sys":
            output.append(line)
            output.append("import shutil")
        elif stripped in {
            "options_ = options.parse_args(args)",
            "print(\"exec hinting\", options_)",
        }:
            continue
        elif stripped == "ttfautohint(**options_)":
            output.append("    shutil.copy(input_font_path, output_font_path)")
        else:
            output.append(line)
    path.write_text("\n".join(output) + "\n")
    PY

        fontforge -lang=py -script fontforge_script.py --do-not-delete-build-dir --jpdoc
        python fonttools_script.py JPDOC-

        runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 build/UDEVGothicJPDOC-*.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "UDEV Gothic JPDOC build from upstream source";
    homepage = "https://github.com/yuru7/udev-gothic";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
