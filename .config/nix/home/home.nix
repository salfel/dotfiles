{ pkgs, ... }:

let 
  custom-pkgs = import ../pkgs { inherit pkgs; };
in {
  imports = [
    ./shell
    ./wofi.nix
  ];

  home.username = "felix";
  home.homeDirectory = "/home/felix";

  home.packages = [
    custom-pkgs.banana-cursor
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = custom-pkgs.banana-cursor;
    size = 64;
    name = "Banana-Catppuccin-Mocha";
  };

  home.file = {
    ".config/nvim".source = ../../nvim;
    ".config/tmux".source = ../../tmux;
    ".config/waybar".source = ../../waybar;
    ".config/fastfetch".source = ../../fastfetch;
    ".config/hypr".source = ../../hypr;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.05"; 
}
