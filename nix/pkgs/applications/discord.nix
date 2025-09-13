{
  pkgs,
  makeDesktopItem,
}:
makeDesktopItem {
  name = "Discord";
  desktopName = "Discord";
  exec = "${pkgs.chromium}/bin/discord";
  icon = "/home/felix/Downloads/discord.svg";
  terminal = false;
  type = "Application";
  comment = "Discord";
  categories = ["Network" "InstantMessaging" "Chat"];
}
