{
  pkgs,
  makeDesktopItem,
}:
makeDesktopItem {
  name = "Discord";
  desktopName = "Discord";
  exec = "${pkgs.brave}/bin/brave --app=https://discord.com/channels/@me/";
  icon = ./icons/discord.svg;
  terminal = false;
  type = "Application";
  comment = "Discord";
  categories = ["Network" "InstantMessaging" "Chat"];
}
