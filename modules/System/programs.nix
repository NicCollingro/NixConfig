{pkgs, ...}:
{
  #programs
  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.hyprland.enable = true;

  #system-wide
  environment.systemPackages = with pkgs; [
    vim
    wget
    helix
    fastfetch
    home-manager
  ];
}
