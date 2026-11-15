{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;   # for apps that speak PulseAudio (Spotify, Firefox, …)

    extraConfig.pipewire."10-hifi" = {
      "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.allowed-rates" = [ 44100 48000 88200 96000 176400 192000 352800 384000 ];
      };
    };

    wireplumber.extraConfig."51-fiio-k11" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "node.name" = "alsa_output.usb-FIIO_FiiO_K11-01.analog-stereo"; } ];
          actions.update-props = {
            "audio.rate" = 384000;
            "audio.allowed-rates" = [ 384000 ];
            "api.alsa.period-size" = 4096;   # bigger buffer for 384 kHz, against crackling
          };
        }
      ];
    };
  };
}
