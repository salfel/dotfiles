{ config, pkgs, ... }:
{
  programs.lazygit = {
    enable = true;

    catppuccin = {
      enable = true;
      accent = "rosewater";
    };
  };
}
