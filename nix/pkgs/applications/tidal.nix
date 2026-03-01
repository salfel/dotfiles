{
  pkgs,
  makeDesktopItem,
}:
makeDesktopItem {
  name = "Tidal";
  desktopName = "Tidal";
  exec = "${pkgs.brave}/bin/brave --app=https://tidal.com/";
  icon = ./icons/tidal.svg;
  terminal = false;
  type = "Application";
  comment = "Tidal Music";
  categories = ["Audio" "AudioVideo" "Player"];
}
