{ pkgs, ... }:
let
        # KiCad runs natively on Wayland by default: under XWayland the 3D viewer
        # renders black (NVIDIA + wxWidgets 3.3 EGL). If "New Project" crashes under
        # Wayland, use `kicad-x11` as a fallback launcher.
        kicad-x11 = pkgs.writeShellScriptBin "kicad-x11" ''
                export GDK_BACKEND=x11
                exec ${pkgs.kicad}/bin/kicad "$@"
        '';
in
{
        home.packages = [ pkgs.kicad kicad-x11 ];
}
