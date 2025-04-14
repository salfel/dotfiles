{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ powertop tlp auto-cpufreq ];

  services.tlp = {
    enable = true;
    settings = { };
  };

  services.power-profiles-daemon.enable = false;
}
