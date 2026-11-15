{ pkgs, ... }:
{
  home.packages = [ pkgs.wl-clipboard ];   # wl-copy / wl-paste

  services.cliphist = {
    enable = true;
    allowImages = true;   # also remember copied images (e.g. screenshots)
  };
}
