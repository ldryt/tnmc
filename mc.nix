{ config, pkgs, ... }:
let 
  MemTotalKB = builtins.fromJSON (builtins.readFile "/var/MemTotalKB");
in
{
  networking.firewall.enable = false; # Hetzner's firewall is in use

  virtualisation.podman.enable = true;
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      mc = {
        image = "ghcr.io/itzg/minecraft-server@sha256:2adc322f52549917a99f0d6e851c2e3d5893dd5f4a38e9e2420c5cbee486a476";
        ports = [ "25565:25565" ];
        volumes = [ "mc_data:/data" ];
        environment = {
          MEMORY = (builtins.toJSON (builtins.floor (MemTotalKB*(0.85))) + "k");
          USE_AIKAR_FLAGS = "true"; # https://docs.papermc.io/paper/aikars-flags
          VERSION = "1.20.2";
          EULA = "true";
        };
      };
    };
  };
}
