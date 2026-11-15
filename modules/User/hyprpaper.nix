{
  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;   # no Hyprland text drawn over the wallpaper

      wallpaper = [
        {
          monitor = "";                                    # empty = all monitors
          path = "${../../wallpapers/gruvbox_topology.png}";
          fit_mode = "cover";                              # fill screen, crop if needed
        }
      ];
    };
  };
}
