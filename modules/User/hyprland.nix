{lib, pkgs, ...}:
let
	lua = lib.generators.mkLuaInline;
	bind = key: action: { _args = [ key (lua action)];};
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
			};
					
			bind = [
				(bind "SUPER + Return" (exec "kitty"))
				(bind "SUPER + Q" (exec "kitty"))
				(bind "SUPER + I" (exec "firefox"))
				(bind "SUPER + E" (exec "nautilus"))
				(bind "SUPER + C" "hl.dsp.window.close()")
				(bind "SUPER + SHIFT + M" "hl.dsp.exit()")
				(bind "SUPER + M" (exec "spotify"))
				(bind "SUPER + D" (exec "vesktop"))
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
