{
  # sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
    wireplumber.enable = true;
    wireplumber.extraConfig = {
      "50-bluez" = {
        "monitor.bluez.rules" = [{
          matches = [{ "device.name" = "~bluez_card.*"; }];
          actions = {
            update-props = {
              "bluez5.auto-connect" = [ "a2dp_sink" "a2dp_source" ];
              "bluez5.hw-volume" = [ "a2dp_sink" "a2dp_source" ];
            };
          };
        }];
        "monitor.bluez.properties" = {
          "bluez5.roles" =
            [ "a2dp_sink" "a2dp_source" "bap_sink" "bap_source" ];

          "bluez5.codecs" = [
            "ldac"
            "aptx"
            "aptx_ll_duplex"
            "aptx_ll"
            "aptx_hd"
            "opus_05_pro"
            "opus_05_71"
            "opus_05_51"
            "opus_05"
            "opus_05_duplex"
            "aac"
            "sbc_xq"
          ];

          "bluez5.hfphsp-backend" = "none";
        };
      };
    };
  };
}
