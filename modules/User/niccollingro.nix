{
  home.username = "niccollingro";
  home.homeDirectory = "/home/niccollingro";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  services.home-manager.autoExpire = {
    enable = true;
    frequency = "weekly";
    timestamp = "-14 days";
  };

  imports = [
    ./kitty.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./claude.nix
    ./waybar.nix
    ./fuzzel.nix	
    ./sway.nix
    ./evince.nix
    ./loupe.nix
    ./vesktop.nix
    ./simpleScan.nix
    ./kicad.nix
    ./whatsapp.nix
    ./powermenu.nix
    ./teams.nix
    ./thunderbird.nix
    ./gimp.nix
    ./freecad.nix
    ./codium.nix
    ./uv.nix
    ./btop.nix
    ./typst.nix
    ./swayosd.nix
    ./gtk.nix
    ./screenshot.nix
    ./clipboard.nix
    ./spotify.nix
    ./qobuz.nix
    ./rebuild.nix
    ./playerctl.nix
    ./solar.nix
    ./mouse-battery.nix
  ];
}
