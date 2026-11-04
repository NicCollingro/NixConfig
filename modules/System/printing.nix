{ pkgs, ... }:
{
  # Printing (CUPS)
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];   # HP's official Linux drivers
  };

  # Network printer/scanner discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Scanning (SANE)
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.hplip          # HP's scanner driver
      pkgs.sane-airscan   # driverless scanning over the network (eSCL/WSD)
    ];
  };
  #system-config-printers
  programs.system-config-printer.enable = true;
}
