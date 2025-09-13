{
  pkgs,
  inputs,
  system,
  ...
}: {
  environment.systemPackages = with pkgs; [
    libreoffice
    obsidian
    inputs.zen-browser.packages."${system}".default
    lunar-client
    steam
    (chromium.override {enableWideVine = true;})
    filezilla
  ];
}
