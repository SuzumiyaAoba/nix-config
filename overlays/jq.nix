final: prev: {
  jq = prev.jq.overrideAttrs (oldAttrs: {
    version = "1.8.0";

    src = prev.fetchurl {
      url = "https://github.com/jqlang/jq/releases/download/jq-1.8.0/jq-1.8.0.tar.gz";
      hash = "sha256-kYEVd/kdmmGV/1DCv/7JtyyEKdwF7D6gIv2VwG0rMZw=";
    };
  });
}
