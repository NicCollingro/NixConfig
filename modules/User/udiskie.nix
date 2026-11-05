{
  services.udiskie = {
    enable = true;
    automount = true;   # mount on plug-in
    notify = true;      # notification via SwayNC
    tray = "auto";      # icon in Waybar's tray while a drive is mounted
  };
}
