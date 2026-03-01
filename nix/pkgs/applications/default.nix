pkgs: [
  (pkgs.callPackage ./spotify.nix {inherit pkgs;})
  (pkgs.callPackage ./tidal.nix {inherit pkgs;})
]
