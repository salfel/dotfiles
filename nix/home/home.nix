{
  pkgs,
  config,
  ...
}: let
  customPkgs = import ../pkgs {inherit pkgs;};
in {
  imports = [./shell ./applications ./secrets.nix ./languages];

  catppuccin.accent = "lavender";

  nix = {
    package = pkgs.nix;
    settings = {experimental-features = ["flakes" "nix-command"];};
  };

  home.username = "felix";
  home.homeDirectory = "/home/felix";

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

  home.sessionPath = [
    "${config.home.homeDirectory}/go/bin"
    "${config.home.homeDirectory}/.cargo/bin"
  ];

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
