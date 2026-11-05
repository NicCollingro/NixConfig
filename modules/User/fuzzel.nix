let c = import ./colorthemes.nix; in
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
        background      = "${c.base}e6";
        text            = "${c.text}ff";
        match           = "${c.blue}ff";
        selection       = "${c.blue}4d";
        selection-text  = "${c.text}ff";
        border          = "${c.blue}ff";
      };

      border = {
        width = 2;
        radius = 10;                 # rounded corners, matches your Hyprland rounding
      };
    };
  };
}
