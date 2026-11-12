{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
    package = pkgs.btop-cuda;   # version with NVIDIA GPU monitoring

    settings = {
      theme_background = false;  # use kitty's (transparent) background
      vim_keys = true;           # also navigate with h/j/k/l
      update_ms = 1000;          # refresh once per second
      proc_tree = true;          # show processes as a tree
    };
  };
}
