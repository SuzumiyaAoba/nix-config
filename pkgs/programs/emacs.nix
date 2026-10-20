{ pkgs, upstreamEmacs }:
let
  # Ship a patched ddskk-autoloads.el that disables skk-isearch-really-early-advice,
  # which breaks isearch under ddskk on this emacs build.
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
emacs
