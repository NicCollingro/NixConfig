{ config, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;   # für Steam/32-bit-Spiele
  };

  services.xserver.videoDrivers = [ "nvidia" ];  # gilt auch unter Wayland

  hardware.nvidia = {
    modesetting.enable = true;  # nötig für Hyprland
    open = true;                # siehe Tabelle unten
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
