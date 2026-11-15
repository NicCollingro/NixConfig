let
  c = import ./colorthemes.nix;
  flare = 15;                                   # size of the outward curves in px
  f = "${toString flare}px";                    # "30px"
  f1 = "${toString (flare - 1)}px";             # "29px" – 1px before the edge, for a smooth but sharp line
  barBg = "#${c.base}";
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;   # start Waybar automatically together with Hyprland

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      
      margin-top = 0;
      margin-left = 300;
      margin-right = 300;
      # Which modules appear where on the bar
      modules-left   = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right  = [ "pulseaudio" "network" "custom/notification" "custom/power"];

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
        font-size: 18px;
	      border: none;
        border-radius: 0;      /* remove the GTK theme's rounding */
        box-shadow: none;
        text-shadow: none;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        background-image:
          radial-gradient(circle ${f} at 0px ${f}, alpha(${barBg}, 0) ${f1}, ${barBg} ${f}),
          radial-gradient(circle ${f} at ${f} ${f}, alpha(${barBg}, 0) ${f1}, ${barBg} ${f});
        background-size: ${f} ${f};
        background-position: left top, right top;
        background-repeat: no-repeat;
        color: #${c.text};
      }

      window#waybar > box {
        background: ${barBg};
        margin: 0 ${f};
        border-radius: 0 0 12px 12px;
        padding: 0 8px;
      }

      #workspaces button {
        color: #${c.text};
	      padding: 0px 2px;
        margin: 2px 5px;
        border-radius: 3px;
        min-height: 0;
      }

      #workspaces button.active {
        background: alpha(#${c.accent}, 0.3);
      }
     
      #custom-power {
        color: #${c.red};
        padding: 0 12px;
      }

      #clock, #pulseaudio, #network, #custom-notification {
        padding: 0px 10px;
      }
    '';
  };
}
