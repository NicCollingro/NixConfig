{lib, pkgs, ...}:
let
	lua = lib.generators.mkLuaInline;
	bind = key: action: { _args = [ key (lua action)];};
	mouseBind = key: action: { _args = [ key (lua action) { mouse = true; } ]; };
	exec= cmd: ''hl.dsp.exec_cmd("${cmd}")'';
in
{
	wayland.windowManager.hyprland = {
		enable = true;
		package = null;
		portalPackage = null;
		settings = {
			config = {
				input.kb_layout = "de";
				cursor.no_hardware_cursors = true;			
				decoration = {
					rounding = 10;
					rounding_power = 2;
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
				(bind "SUPER + F" "hl.dsp.window.fullscreen()")
				(bind "SUPER + V"''hl.dsp.window.float({action = "toggle"})'')

				(mouseBind "SUPER + mouse:272" "hl.dsp.window.drag()")
				(mouseBind "SUPER + mouse:273" "hl.dsp.window.resize()")
			];

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
		};
	};
	home.pointerCursor={
		enable = true;
		package=pkgs.bibata-cursors;
		name = "Bibata-Modern_classic";
		size=24;
		gtk.enable = true;
		x11.enable = true;
	};
}
