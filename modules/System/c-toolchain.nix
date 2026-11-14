{ pkgs, ... }:
{
  # C toolchain for embedded / native C projects
  environment.systemPackages = with pkgs; [
    gcc         # C compiler (+ the linker via binutils)
    cmake       # build system generator (LVGL ships CMake files)
    gnumake     # runs the Makefiles CMake generates (instead of ninja)
    pkg-config  # how CMake finds libraries like SDL2
    gdb         # debugger, handy when the emulator crashes
  ];
}
