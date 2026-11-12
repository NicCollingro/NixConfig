{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib   # libstdc++ – needed by numpy, pandas, torch, …
      zlib
    ];
  };
}
