{
  home.username = "niccollingro";
  home.homeDirectory = "/home/niccollingro";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  imports = [
    ./hyprland.nix
  ];
}
