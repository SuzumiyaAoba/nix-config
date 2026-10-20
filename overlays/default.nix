{ inputs }:
[
  (import ./ollama.nix)
  inputs.moonbit-overlay.overlays.default
  (import ./direnv-mise.nix)
]
