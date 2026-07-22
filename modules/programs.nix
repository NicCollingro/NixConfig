{
  #programs
  programs.firefox.enable = true;

  #system-wide
  environment.systemPackages = with pkgs; [
    vim
    wget
    helix
    fastfetch
  ];
}
