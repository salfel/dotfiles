{
  pkgs,
  makeDesktopItem,
}:
makeDesktopItem {
  name = "WhatsApp";
  desktopName = "WhatsApp";
  exec = "${pkgs.brave}/bin/brave --app=https://web.whatsapp.com/";
  icon = "/home/felix/Downloads/whatsapp.svg";
  terminal = false;
  type = "Application";
  comment = "WhatsApp Web";
  categories = ["Network" "InstantMessaging" "Chat"];
}
