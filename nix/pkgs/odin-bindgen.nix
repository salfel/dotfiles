{
  stdenv,
  fetchFromGitHub,
  odin,
}:
stdenv.mkDerivation rec {
  pname = "odin-bindgen";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "karl-zylinski";
    repo = "odin-c-bindgen";
    rev = "${version}";
    sha256 = "sha256-Aozz+0KZg7hOZpQi+RKRRLVfMKduLvmXxTaBSN0Ve8I=";
  };

  nativeBuildInputs = [
    (odin.overrideAttrs (old: rec {
      version = "dev-2025-11";
      src = fetchFromGitHub {
        owner = "odin-lang";
        repo = "Odin";
        tag = version;
        hash = "sha256-Nyi8/52xexGPSnWIF8eMSMqaXFQD57dDRGl6IuZcppw=";
      };
    }))
  ];

  buildPhase = ''
    odin build src -out:odin-bindgen
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp odin-bindgen $out/bin
  '';
}
