{ config, pkgs, ... }:

{
  home.username = "felix";
  home.homeDirectory = "/home/felix";

  home.packages = with pkgs;[
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.05"; 
}
