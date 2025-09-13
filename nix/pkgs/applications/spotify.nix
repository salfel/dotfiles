{
  pkgs,
  makeDesktopItem,
}:
makeDesktopItem {
  name = "Spotify";
  desktopName = "Spotify";
  exec = "${pkgs.chromium}/bin/chromium --app=https://open.spotify.com/";
  icon = "/home/felix/Downloads/spotify.svg";
  terminal = false;
  type = "Application";
  comment = "Spotify Music";
  categories = ["Audio" "AudioVideo" "Player"];
}
