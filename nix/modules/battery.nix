{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ auto-cpufreq ];

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        boost = false;
        temperature_limit = 80;
      };
      charger = {
        governor = "performance";
        boost = true;
        temperature_limit = 90;
      };
    };
  };

  services.power-profiles-daemon.enable = false;
}
