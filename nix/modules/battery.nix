{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ powertop tlp ];

  services.tlp = {
    enable = true;
    settings = { };
  };

  services.power-profiles-daemon.enable = false;
}
