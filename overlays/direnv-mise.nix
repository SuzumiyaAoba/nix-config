final: prev: {
  direnv = prev.direnv.overrideAttrs (_old: {
    # The fish test is killed on aarch64-darwin during local system builds.
    doCheck = false;
  });
  mise = (prev.mise.override { inherit (final) direnv; }).overrideAttrs (_old: {
    # Avoid rebuilding the full mise test suite for system activation builds.
    doCheck = false;
  });
}
