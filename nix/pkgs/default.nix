{pkgs, ...}: {
  banana-cursor = pkgs.callPackage ./banana-cursor {inherit pkgs;};
}
