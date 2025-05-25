{
  pkgs,
  inputs,
  system,
  ...
}: {
  environment.systemPackages = with pkgs; [
    spotify
    discord
    libreoffice
    obsidian
    inputs.zen-browser.packages."${system}".default
    lunar-client
    steam
    chromium
  ];
}
