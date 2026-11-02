{
  home.username = "niccollingro";
  home.homeDirectory = "/home/niccollingro";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  imports = [
    ./kitty.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./claude.nix
    ./waybar.nix
    ./fuzzel.nix	
    ./sway.nix
  ];
}
