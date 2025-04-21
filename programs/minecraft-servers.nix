{ pkgs, lib, inputs, ... }:
let
  inherit (lib) filterAttrs attrValues elem flatten concatStringsSep;

  jre8 = pkgs.openjdk8-bootstrap;
  jre17 = pkgs.openjdk17-bootstrap;
  jre21 = pkgs.temurin-bin-21;

  jvmOpts = concatStringsSep " " [
    "-XX:+UseG1GC"
    "-XX:+ParallelRefProcEnabled"
    "-XX:MaxGCPauseMillis=200"
    "-XX:+UnlockExperimentalVMOptions"
    "-XX:+DisableExplicitGC"
    "-XX:+AlwaysPreTouch"
    "-XX:G1NewSizePercent=40"
    "-XX:G1MaxNewSizePercent=50"
    "-XX:G1HeapRegionSize=16M"
    "-XX:G1ReservePercent=15"
    "-XX:G1HeapWastePercent=5"
    "-XX:G1MixedGCCountTarget=4"
    "-XX:InitiatingHeapOccupancyPercent=20"
    "-XX:G1MixedGCLiveThresholdPercent=90"
    "-XX:G1RSetUpdatingPauseTimePercent=5"
    "-XX:SurvivorRatio=32"
    "-XX:+PerfDisableSharedMem"
    "-XX:MaxTenuringThreshold=1"
  ];

in
{
  imports = [ inputs.minecraft-servers.module ];

  services.modded-minecraft-servers = {
    eula = true;
    
    instances = {
      atm10 = {
        enable = true;
        
        jvmPackage = jre21;
        jvmMaxAllocation = "16G";
        jvmInitialAllocation = "4G";

	rsyncSSHKeys = [
	  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID+XMM+srxrwhJmj/DjO689MdrfzTNuxArRq/RGYFl/v"
	];

        serverConfig = {
          server-port = 25565;
          white-list = true;
	  spawn-protection = 0;
	  allow-flight = true;
	  max-tick-time = 5 * 60 * 1000; #5 minutes
	  motd = "All the Mods 10";
        };
      };
    };
  };
}
