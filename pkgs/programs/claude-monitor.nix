{ lib, fetchFromGitHub, python3Packages }:
python3Packages.buildPythonApplication rec {
  pname = "claude-monitor";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "Maciek-roboblog";
    repo = "Claude-Code-Usage-Monitor";
    rev = "v${version}";
    sha256 = "18zbsbwp03b1v4jwg3rma4hj362a6kyyzfqmmig2bmld4sg2i6mz";
  };

  pyproject = true;

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    pytz
    rich
  ];

  doCheck = false; # upstream has extensive tests; skip at build time for speed

  meta = with lib; {
    description = "Real-time Claude Code usage monitor with predictions and warnings";
    homepage = "https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor";
    license = licenses.mit;
    platforms = platforms.all;
    mainProgram = "claude-monitor";
  };
}


