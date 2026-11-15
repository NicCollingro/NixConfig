{ pkgs, ... }:
let
  c = import ./colorthemes.nix;
  flare = 15;                                   # size of the outward curves in px
  f = "${toString flare}px";                    # "15px"
  f1 = "${toString (flare - 1)}px";             # "14px" – 1px before the edge, for a smooth but sharp line
  barBg = "#${c.base}";

  ha-temp = pkgs.writeShellScriptBin "ha-temp" ''
    HA_URL="http://192.168.178.150"      # ← your HA address
    ENTITY="sensor.outside_temperature"            # ← your sensor's entity ID

    TOKEN=$(cat ~/.config/homeassistant/token 2>/dev/null) \
      || { echo '{"text":"--°C","tooltip":"No token file"}'; exit 0; }

    DATA=$(${pkgs.curl}/bin/curl -sf --max-time 5 \
      -H "Authorization: Bearer $TOKEN" \
      "$HA_URL/api/states/$ENTITY") \
      || { echo '{"text":"--°C","tooltip":"Home Assistant not reachable"}'; exit 0; }

    echo "$DATA" | ${pkgs.jq}/bin/jq -c '{
      text: (.state + "°C"),
      tooltip: ("Outside: " + .state + " " + .attributes.unit_of_measurement
                + "\nUpdated: " + .last_updated[11:16])
    }'
  '';
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
      modules-right  = [ "custom/outside" "pulseaudio" "network" "custom/notification" "custom/power"];

      "hyprland/workspaces" = {
        format = "{id}";
        #persistent-workspaces = { "*" = 5; };   # always show 1–5
      };

      clock = {
        format = "{:%H:%M}";
	format-alt = "{:%A, %d. %B %H:%M}";
        tooltip-format = "<tt>{calendar}</tt>";   # hover = calendar
        
   	calendar = {
          mode = "month";
          weeks-pos = "left";                      # show calendar weeks
          format = {
            today = "<span color='#${c.accent}'><b>{}</b></span>";   # today in Gruvbox green
            weeks = "<span color='#${c.gray}'>{}</span>";             # week numbers in grey
            weekdays = "<span color='#${c.yellow}'>{}</span>";        # Mo Tu We… in yellow
          };
	};
      };

      "custom/outside" = {
        exec = "${ha-temp}/bin/ha-temp";
        return-type = "json";
        interval = 300;          # update every 5 minutes
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
        color: #${c.surface};      /* inactive dots: brownish grey */
        padding: 0 4px;
        margin: 2px 2px;
      }

      #workspaces button.active {
        color: #${c.accent};       /* active dot: Gruvbox green */
        background: transparent;
      }     
      #custom-power {
        color: #${c.red};
        padding: 0 12px;
      }

      #clock, #pulseaudio, #network, #custom-notification {
        padding: 0px 10px;
      }

      #clock {
        font-weight: bold;
        color: #${c.text};
      }
    '';
  };
}
