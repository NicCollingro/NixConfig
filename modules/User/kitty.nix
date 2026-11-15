{ pkgs, ...}:
let c = import ./colorthemes.nix; in
{
  programs.kitty = {
    enable = true;

    themeFile = "gruvbox-dark-soft";

    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
    };
   
    settings = {
      window_padding_width = 8;
      background = "#${c.base}";
      foreground = "#${c.text}";
      cursor = "#${c.accent}";
    };
  };
}
