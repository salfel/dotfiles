{
  pkgs,
  customPkgs,
  ...
}: {
  imports = [./languages ./terminal ./secrets.nix];

  catppuccin.accent = "lavender";

  nix = {
    # package = pkgs.nix;
    settings = {experimental-features = ["flakes" "nix-command"];};
  };

  home.packages = [customPkgs.banana-cursor] ++ customPkgs.applications;

  home.username = "felix";
  home.homeDirectory = "/home/felix";

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
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

  home.stateVersion = "25.11";
}
