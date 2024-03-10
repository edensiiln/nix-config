{config, pkgs, ... }:
{
  networking = {
    hostName = systemSettings.hostname;
    networkmanager.enable = true;
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
