pkgs: [
  (pkgs.callPackage ./spotify.nix {inherit pkgs;})
]
