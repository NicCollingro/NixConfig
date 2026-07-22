{pkgs, ...}:
{
  users.users.niccollingro = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    description = "Nic Collingro";
    shell = pkgs.bash;
  };
}
