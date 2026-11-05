let c = import ./colorthemes.nix; in
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
      modules-right  = [ "tray" "pulseaudio" "network" "custom/notification" "custom/power"];

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

      "custom/notification" = {
        exec = "swaync-client -swb";
        return-type = "json";
        format = "{icon}";
        format-icons = {
          none = "󰂚";                    # no notifications
    	  notification = "󱅫";            # unread notifications
    	  dnd-none = "󰂛";                # do-not-disturb on
    	  dnd-notification = "󰂛";
  	};
  	on-click = "swaync-client -t -sw";        # left-click: open panel
  	on-click-right = "swaync-client -d -sw";  # right-click: toggle do-not-disturb
	escape = true;
      };

      "custom/power" = {
	format = "󰐥";
  	tooltip-format = "Power menu";
  	on-click = "powermenu";
      };
    };

    # CSS, like on a website
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }

      window#waybar {
        background: alpha(#${c.base}, 0.85);
        color: #${c.text};
      }

      #workspaces button {
        color: #${c.text};
	padding: 2px 2px;
        margin: 10px 10px;
	min-height: 0;
      }

      #workspaces button.active {
        background: alpha(#${c.blue}, 0.3);
      }
     
      #custom-power {
        color: #${c.red};
        padding: 0 12px;
      }

      #clock, #tray, #pulseaudio, #network, #custom-notification {
        padding: 0px 10px;
      }
    '';
  };
}
