_final: prev: {
  ollama = prev.ollama.overrideAttrs (old: {
    # Some revisions refer to a test file absent from the fetched source.
    postPatch =
      builtins.replaceStrings
        [ "rm model/models/nemotronh/model_omni_test.go" ]
        [ "rm -f model/models/nemotronh/model_omni_test.go" ]
        old.postPatch;
  });
}
