{ pkgs, ... }:
let
  mouse-battery-check = pkgs.writeShellScriptBin "mouse-battery-check" ''
    # Find the MX Master among all batteries the system knows
    for dev in /sys/class/power_supply/*; do
      if [ "$(cat "$dev/model_name" 2>/dev/null)" = "MX Master 3S" ]; then
        level=$(cat "$dev/capacity")
        break
      fi
    done
    [ -z "$level" ] && exit 0          # mouse off or not connected: nothing to do

    # Remember which warning was already shown, so you don't get spammed
    state="$XDG_RUNTIME_DIR/mouse-battery-warned"
    last=$(cat "$state" 2>/dev/null || echo 100)

    for t in 5 10 20; do
      if [ "$level" -le "$t" ] && [ "$last" -gt "$t" ]; then
        urgency=normal
        [ "$t" -le 10 ] && urgency=critical
        ${pkgs.libnotify}/bin/notify-send -u "$urgency" -a "Mouse" \
          "MX Master 3S battery low" "$level% left, time to charge"
        echo "$t" > "$state"
        exit 0
      fi
    done

    # After charging above 20%: reset, so the warnings work again next time
    [ "$level" -gt 20 ] && echo 100 > "$state"
  '';
in
{
  home.packages = [ mouse-battery-check ];

  systemd.user.services.mouse-battery = {
    Unit.Description = "Warn when the MX Master battery is low";
    Service = {
      Type = "oneshot";
      ExecStart = "${mouse-battery-check}/bin/mouse-battery-check";
    };
  };

  systemd.user.timers.mouse-battery = {
    Unit.Description = "Check the mouse battery every 10 minutes";
    Timer = {
      OnBootSec = "2min";          # first check 2 minutes after login
      OnUnitActiveSec = "10min";   # then every 10 minutes
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
