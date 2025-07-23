{
  nixpkgs.overlays = [
    (import ./hyprsunset.nix)
  ];
}
