{ pkgs, ... }:
{
  home.packages = [ pkgs.playerctl ];   # CLI: playerctl play-pause, next, …
  services.playerctld.enable = true;    # remembers which player was used last
}
