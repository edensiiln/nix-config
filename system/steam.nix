{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    steamModule.enable = lib.mkEnableOption "enable steam";
  };

  config = lib.mkIf config.steamModule.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
