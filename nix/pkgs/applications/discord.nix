{
  pkgs,
  makeDesktopItem,
}:
makeDesktopItem {
  name = "Discord";
  desktopName = "Discord";
  exec = "${pkgs.brave}/bin/brave --app=https://discord.com/channels/@me/";
  icon = "/home/felix/Downloads/discord.svg";
  terminal = false;
  type = "Application";
  comment = "Discord";
  categories = ["Network" "InstantMessaging" "Chat"];
}
