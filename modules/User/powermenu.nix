{ pkgs, ... }:
let
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    choice=$(printf "󰐥  Shutdown\n󰜉  Reboot\n󰍃  Logout" | fuzzel --dmenu --prompt "Power: " --lines 3)

    case "$choice" in
      *Shutdown) systemctl poweroff ;;
      *Reboot)   systemctl reboot ;;
      *Logout)   loginctl terminate-session "$XDG_SESSION_ID" ;;
    esac
  '';
in
{
  home.packages = [ powermenu ];
}
