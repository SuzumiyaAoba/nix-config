{
  delib,
  emacs-flake,
  pkgs,
  ...
}:
delib.module {
  name = "programs.emacs";

  options = delib.singleEnableOption false;

  darwin.ifEnabled =
    let
      upstreamEmacs = emacs-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
      patchedDdskkAutoloads =
        pkgs.runCommand "ddskk-autoloads-patched"
          {
            nativeBuildInputs = [
              upstreamEmacs
              pkgs.gnused
            ];
          }
          ''
            export HOME="$TMPDIR/home"
            mkdir -p "$HOME"

            src="$(${upstreamEmacs}/bin/emacs --batch --eval '(princ (or (locate-library "ddskk-autoloads") ""))' 2>/dev/null)"
            if [ -z "$src" ]; then
              echo "failed to locate ddskk-autoloads.el" >&2
              exit 1
            fi

            mkdir -p "$out/share/emacs/site-lisp"
            sed -E \
              's#^\(defconst skk-isearch-really-early-advice .*$#(defconst skk-isearch-really-early-advice nil)#' \
              "$src" > "$out/share/emacs/site-lisp/ddskk-autoloads.el"
          '';
      emacs = pkgs.writeShellScriptBin "emacs" ''
        exec ${upstreamEmacs}/bin/emacs \
          --directory ${patchedDdskkAutoloads}/share/emacs/site-lisp \
          "$@"
      '';
    in
    {
      environment.systemPackages = [
        emacs
      ];
    };
}
