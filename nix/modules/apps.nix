{ pkgs, inputs, ... }: 
{
  environment.systemPackages = with pkgs; [
  spotify
  discord
  libreoffice
  obsidian
  inputs.zen-browser.packages."${system}".specific
  ];
}
