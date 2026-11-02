{
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";

      timeout = 6;            # seconds a normal notification stays visible
      timeout-low = 3;        # low-priority ones disappear faster
      timeout-critical = 0;   # 0 = critical ones stay until you close them

      notification-window-width = 400;
      control-center-width = 400;

      # What the notification center panel shows, top to bottom
      widgets = [ "title" "dnd" "notifications" ];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear all";
        };
        dnd.text = "Do not disturb";
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
      }

      .notification,
      .control-center {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
        border: 2px solid #89b4fa;
        border-radius: 10px;
      }
    '';
  };
}
