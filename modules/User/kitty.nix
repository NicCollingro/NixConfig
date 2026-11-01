{ pkgs, ...}:
{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
    };
   
    settings = {
      window_padding_width = 8;
    };
  };
}
