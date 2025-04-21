{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    plexModule.enable = lib.mkEnableOption "enable plex";
  };

  config = lib.mkIf config.plexModule.enable {
    services.plex = {
      enable = true;
      openFirewall = true;
    };
  };
}
