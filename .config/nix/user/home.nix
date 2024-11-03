{ config, pkgs, lib, builtins, ... }:

let 
  custom-pkgs = import ./pkgs { inherit pkgs; };
in {
  imports = [
    ./shell
    ./wofi.nix
  ];

  home.username = "felix";
  home.homeDirectory = "/home/felix";

  home.packages = with pkgs; [
    custom-pkgs.banana-cursor

    hyprpanel
  ];

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = custom-pkgs.banana-cursor;
    size = 64;
    name = "Banana-Catppuccin-Mocha";
  };

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.05"; 
}
