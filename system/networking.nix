{
  config,
  pkgs,
  lib,
  systemSettings,
  ...
}: let
  MCPort = 25565;
in {
  options = {
    networkingModule.enable = lib.mkEnableOption "enable networking";
  };

  config = lib.mkIf config.networkingModule.enable {
    networking =
    if systemSettings.profile == "homelab"
    then {

      hostName = systemSettings.hostname;
      networkmanager.enable = true;

      nftables = {
        enable = true;
        ruleset = ''
          table ip nat {
            chain PREROUTING {
              type nat hook prerouting priority dstnat; policy accept;
              iifname "wlp4s0" tcp dport ${MCPort} dnat to 192.168.1.1:${MCPort}
            }
          }
	      '';
      };

      firewall = {
        enable = true;
        allowedTCPPorts = [
          MCPort
        ];
      };

      nat = {
        enable = true;
        internalInterfaces = [ "eno1" ];
        externalInterface = "eno1";
        forwardPorts = [
          {
            sourcePort = MCPort;
            proto = "tcp";
            destination = "192.168.1.1:${MCPort}";
          }
        ];
      };
    
    } else if systemSettings.profile == "main"
    then {
      hostName = systemSettings.hostname;
      networkmanager.enable = true;
      
      firewall = {
        enable = true;
	allowedTCPPorts = [
          443
	];
	allowedUDPPorts = [
          1194
	];
      };

    } else {
      hostName = systemSettings.hostname;
      networkmanager.enable = true;
      #proxy.default = "http://user:password@proxy:port/";
      #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };
  };
}
