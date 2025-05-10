{
  config,
  pkgs,
  lib,
  systemSettings,
  ...
}: {
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
              iifname "wlp4s0" tcp dport 25565 dnat to 192.168.1.1:25565
            }
          }
	      '';
      };

      firewall = {
        enable = true;
        allowedTCPPorts = [
          25565
        ];
      };

      nat = {
        enable = true;
        internalInterfaces = [ "eno1" ];
        externalInterface = "eno1";
        forwardPorts = [
          {
            sourcePort = 25565;
            proto = "tcp";
            destination = "192.168.1.1:25565";
          }
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
