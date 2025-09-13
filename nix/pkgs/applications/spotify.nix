{
  pkgs,
  makeDesktopItem,
}:
makeDesktopItem {
  name = "Spotify";
  desktopName = "Spotify";
  exec = "${pkgs.brave}/bin/brave --app=https://open.spotify.com/";
  icon = ./icons/spotify.svg;
  terminal = false;
  type = "Application";
  comment = "Spotify Music";
  categories = ["Audio" "AudioVideo" "Player"];
}
