{ config, pkgs, ... }:
{
  networking.firewall.enable = false; # Hetzner's firewall is in use
  nixpkgs.config.allowUnfree = true;
  services.minecraft-server = {
    enable = true;
    declarative = true;
    eula = true;
    jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";
    serverProperties = {
      server-port = 25565;
      difficulty = "hard";
      gamemode = "survival";
      max-players = 5;
      motd = "yay!";
      enable-rcon = false;
    };
  };
}
