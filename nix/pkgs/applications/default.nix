pkgs: [
  (pkgs.callPackage ./spotify.nix {inherit pkgs;})
  (pkgs.callPackage ./whatsapp.nix {inherit pkgs;})
]
