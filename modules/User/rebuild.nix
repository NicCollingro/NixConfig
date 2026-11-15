{ pkgs, ... }:
let
  hm-update = pkgs.writeShellScriptBin "hm-update" ''
    set -e
    cd ~/NixConfig
    git add -A
    home-manager switch --flake ~/NixConfig#niccollingro "$@"
  '';

  system-update = pkgs.writeShellScriptBin "system-update" ''
    set -e
    cd ~/NixConfig
    git add -A
    sudo nixos-rebuild switch --flake ~/NixConfig#Kopernikus "$@"
  '';

  full-update = pkgs.writeShellScriptBin "full-update" ''
    set -e
    cd ~/NixConfig

    echo "==> Updating flake inputs (nixpkgs, home-manager)"
    nix flake update

    echo "==> Rebuilding system"
    ${system-update}/bin/system-update

    echo "==> Rebuilding home"
    ${hm-update}/bin/hm-update

    echo "==> Done. New versions are active."
  '';
in
{
  home.packages = [ hm-update system-update full-update ];
}
