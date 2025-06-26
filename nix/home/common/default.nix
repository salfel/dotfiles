{
  pkgs,
  customPkgs,
  ...
}: {
  imports = [./languages ./terminal];

  catppuccin.accent = "lavender";

  nix = {
    package = pkgs.nix;
    settings = {experimental-features = ["flakes" "nix-command"];};
  };

  home.packages = [customPkgs.banana-cursor];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = customPkgs.banana-cursor;
    size = 64;
    name = "Banana-Catppuccin-Mocha";
  };

  home.sessionVariables = {EDITOR = "nvim";};

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
