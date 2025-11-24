{pkgs, ...}: {
  banana-cursor = pkgs.callPackage ./banana-cursor {inherit pkgs;};
  font = pkgs.callPackage ./fonts/alfaslabone {inherit pkgs;};
  applications = pkgs.callPackage ./applications pkgs;
  odin-bindgen = pkgs.callPackage ./odin-bindgen.nix {};
}
