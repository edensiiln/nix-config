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
                iifname "wlp4s0" tcp dport 25566 dnat to 192.168.1.1:25566
              }
            }
          '';
        };
        firewall = {
          enable = true;
          allowedTCPPorts = [
            25566
          ];
        };
        nat = {
          enable = true;
          internalInterfaces = ["wlp4s0"];
          externalInterface = "wlp4s0";
          forwardPorts = [
            {
              sourcePort = 25566;
              proto = "tcp";
              destination = "192.168.1.1:25566";
            }
          ];
        };
      }
      else {
        hostName = systemSettings.hostname;
        networkmanager.enable = true;
        #proxy.default = "http://user:password@proxy:port/";
        #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
      };
  };
}
