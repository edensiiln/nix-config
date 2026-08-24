{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    RDServerModule.enable = lib.mkEnableOption "enable remote desktop server";
  };

  config = lib.mkIf config.RDServerModule.enable {
    services.xrdp = {
      enable = true;
      openFirewall = true;
    };
  };
}
