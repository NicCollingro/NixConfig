{pkgs, ...}:
{
  #programs
  programs.firefox.enable = true;
  programs.git.enable = true;

  #system-wide
  environment.systemPackages = with pkgs; [
    vim
    wget
    helix
    fastfetch
  ];
}
