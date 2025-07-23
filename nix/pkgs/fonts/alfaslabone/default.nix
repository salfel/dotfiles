{pkgs}:
pkgs.stdenv.mkDerivation {
  pname = "Alfa Slab one";
  version = "0.1";

  src = ./.;

  installPhase = ''
    mkdir $out/share/fonts/truetype -p

    cp alfaslabone.ttf $out/share/fonts/truetype
  '';
}
