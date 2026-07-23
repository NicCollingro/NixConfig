{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
    wofi
    polkit_gnome
  ];

  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = ",preferred,auto,1";
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, kitty"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, E, exec, wofi --show drun"
        "$mod, V, togglefloating"
      ];
      exec-once = [
        "waybar"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
