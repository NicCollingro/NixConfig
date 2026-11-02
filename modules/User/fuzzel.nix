{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        terminal = "kitty";          # used for terminal apps like htop
        prompt = "'❯ '";
        lines = 10;                  # how many results are shown
        width = 40;                  # width in characters
        horizontal-pad = 20;
        vertical-pad = 10;
      };

      colors = {
        background      = "1e1e2ee6";   # RRGGBBAA – last two digits = transparency
        text            = "cdd6f4ff";
        match           = "89b4faff";   # the letters you typed
        selection       = "89b4fa4d";   # highlighted entry
        selection-text  = "cdd6f4ff";
        border          = "89b4faff";
      };

      border = {
        width = 2;
        radius = 10;                 # rounded corners, matches your Hyprland rounding
      };
    };
  };
}
