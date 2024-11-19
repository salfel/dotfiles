{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    platformio
    kicad
    easyeda2kicad
  ];

  services.udev.packages = with pkgs; [ 
    platformio-core
    platformio-core.udev
    openocd
  ];
}
