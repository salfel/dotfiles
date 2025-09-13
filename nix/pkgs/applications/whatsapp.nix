{
  pkgs,
  makeDesktopItem,
}:
makeDesktopItem {
  name = "WhatsApp";
  desktopName = "WhatsApp";
  exec = "${pkgs.chromium}/bin/chromium --app=https://web.whatsapp.com/";
  icon = "/home/felix/Downloads/whatsapp.svg";
  terminal = false;
  type = "Application";
  comment = "WhatsApp Web";
  categories = ["Network" "InstantMessaging" "Chat"];
}
