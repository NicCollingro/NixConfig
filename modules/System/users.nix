{pkgs, ...}:
{
  users.users.niccollingro = {
    isNormalUser = true;
    extraGroups = ["wheel" "scanner" "lp"];
    description = "Nic Collingro";
    shell = pkgs.bash;
  };
}
