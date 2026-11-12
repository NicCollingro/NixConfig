{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;                # stream games to other devices
    localNetworkGameTransfers.openFirewall = true; # copy games between PCs on your network
  };
}
