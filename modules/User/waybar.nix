{
  programs.waybar = {
    enable = true;
    systemd.enable = true;   # start Waybar automatically together with Hyprland

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;

      # Which modules appear where on the bar
      modules-left   = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right  = [ "tray" "pulseaudio" "network" ];

      clock = {
        format = "{:%d.%m.%Y %H:%M}";
        tooltip-format = "<tt>{calendar}</tt>";   # hover = calendar
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 muted";
        format-icons.default = [ "󰕿" "󰖀" "󰕾" ];   # low / medium / high volume
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };

      network = {
        format-ethernet = "󰈀 wired";
        format-wifi = "󰖩 {essid}";
        format-disconnected = "󰖪 offline";
      };
    };

    # CSS, like on a website
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.85);
        color: #cdd6f4;
      }

      #workspaces button {
        color: #cdd6f4;
	padding: 2 2;
        margin: 10px 10px;
	min-height: 0;
      }

      #workspaces button.active {
        background: rgba(137, 180, 250, 0.3);
      }

      #clock, #tray, #pulseaudio, #network {
        padding: 0 10px;
      }
    '';
  };
}
