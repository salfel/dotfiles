{pkgs, ...}: {
  banana-cursor = pkgs.callPackage ./banana-cursor {inherit pkgs;};
  font = pkgs.callPackage ./fonts/alfaslabone {inherit pkgs;};
}
