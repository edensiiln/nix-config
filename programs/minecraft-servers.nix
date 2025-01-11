{ pkgs, lib, inputs, ... }:
let
  jre8 = pkgs.temurin-bin-8;
  jre17 = pkgs.temurin-bin-17;
in
{
  imports = [ inputs.mms.module ];

  services.modded-minecraft-servers = {
    eula = true;

    atm10 = {
      enable = true;
      
      jvmPackage = jre17;
      jvmMaxAllocation = "6G";
      jvmInitialAllocation = "2G";

      serverConfig = {
        server-port = 25566;
	white-list = true;
	spawn-protection = 0;
	allow-flight = true;
	max-tick-time = 5 * 60 * 1000;	#5 minutes
	motd = "All the Mods 10";
      };
    };
  };
}
