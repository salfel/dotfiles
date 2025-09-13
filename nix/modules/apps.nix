{
  pkgs,
  inputs,
  system,
  ...
}: {
  environment.systemPackages = with pkgs; [
    discord
    libreoffice
    obsidian
    inputs.zen-browser.packages."${system}".default
    lunar-client
    steam
    brave
    filezilla
  ];
}
