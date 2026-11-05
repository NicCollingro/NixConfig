{lib, pkgs, ...}:
let
	lua = lib.generators.mkLuaInline;
	bind = key: action: { _args = [ key (lua action)];};
	mouseBind = key: action: { _args = [ key (lua action) { mouse = true; } ]; };
	exec= cmd: ''hl.dsp.exec_cmd("${cmd}")'';
	workspaceBinds = lib.concatMap (i:
		let
			key = toString (lib.mod i 10);
			ws = toString i;
		in [
			(bind "SUPER + ${key}" "hl.dsp.focus({workspace = ${ws}})")
			(bind "SUPER + SHIFT + ${key}" "hl.dsp.window.move({ workspace = ${ws} })")
		]
	) (lib.range 1 10);
	c = import ./colorthemes.nix;
in
{
	wayland.windowManager.hyprland = {
		enable = true;
		package = null;
		portalPackage = null;
		settings = {
			env = [
				{ _args = [ "LIBVA_DRIVER_NAME" "nvidia"]; }
				{ _args = [ "__GLX_VENDOR_LIBRARY_NAME" "nvidia" ];}
			];
 	        	monitor = [
                        	{
                        		output = "DP-1";                 # LG, left
                                	mode = "2560x1440@143.97";
                                	position = "0x0";
                                	scale = 1;
                        	}
                        	{
                                	output = "DP-3";                 # HP, right
                                	mode = "2560x1440@143.86";
                                	position = "2560x0";
                                	scale = 1;
                        	}
                        ];
			config = {
				input.kb_layout = "de";
				input.numlock_by_default = true;
				cursor.no_hardware_cursors = true;			
				decoration = {
					rounding = 10;
					rounding_power = 2;
				};
				general = {
					border_size = 2;
					col.active_border = "rgb(${c.blue})";
					col.inactive_border = "rgb(${c.surface})";
				};
			};
					
			bind = [
				(bind "SUPER + Return" (exec "kitty"))
				(bind "SUPER + I" (exec "firefox"))
				(bind "SUPER + E" (exec "nautilus"))
				(bind "SUPER + Q" "hl.dsp.window.close()")
				(bind "SUPER + SHIFT + M" "hl.dsp.exit()")
				(bind "SUPER + M" (exec "spotify"))
				(bind "SUPER + D" (exec "vesktop"))
				(bind "SUPER + F" ''hl.dsp.window.fullscreen({mode="maximized", action="toggle"})'')
				(bind "SUPER + SHIFT + F" "hl.dsp.window.fullscreen()")
				(bind "SUPER + V" ''hl.dsp.window.float({action = "toggle"})'')
				(bind "SUPER + SPACE" (exec "fuzzel"))			

				(bind "SUPER + N" (exec "swaync-client -t -sw"))

				(bind "SUPER + Escape" (exec "powermenu"))

				(bind "SUPER + left" ''hl.dsp.focus({ direction = "left" })'')
				(bind "SUPER + right" ''hl.dsp.focus({ direction = "right" })'')
				(bind "SUPER + up" ''hl.dsp.focus({ direction = "up" })'')
				(bind "SUPER + down" ''hl.dsp.focus({ direction = "down" })'')
	
				(mouseBind "SUPER + mouse:272" "hl.dsp.window.drag()")
				(mouseBind "SUPER + mouse:273" "hl.dsp.window.resize()")	
			] ++ workspaceBinds;

			# Ignore apps asking to be maximized (kitty did this and hid other tiles)
			window_rule = [
				{
					name = "suppress-maximize-events";
					match.class = ".*";
					suppress_event = "maximize";
				}
				{
					name = "kitty-transparent";
					match.class = "kitty";
					opacity = "0.9 0.8";
				}
			];
			# unlock keyring at startup
			on = { _args = ["hyprland.start" (lua ''
				function()
					hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
				end
				'')];
			};
		};
	};
	home.pointerCursor={
		enable = true;
		package = pkgs.whitesur-cursors;
		name = "WhiteSur-cursors";
		size=24;
		gtk.enable = true;
		x11.enable = true;
	};
}
