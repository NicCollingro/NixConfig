{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;   # for apps that speak PulseAudio (Spotify, Firefox, …)

    extraConfig.pipewire."10-hifi" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [
          44100 48000 88200 96000 176400 192000 352800 384000
        ];
      };
    };
  };
}
