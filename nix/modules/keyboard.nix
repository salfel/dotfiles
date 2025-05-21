{ pkgs, ... }:
let kmonadCfg = builtins.readFile ./home-row-mods.kbd;
in {
  environment.systemPackages = with pkgs; [ kmonad ];

  services.kmonad = {
    enable = true;
    keyboards = {
      "integrated-keyboard" = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = kmonadCfg;
      };
    };
  };
}
