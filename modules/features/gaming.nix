{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.edenGaming = {
    pkgs,
    lib,
    ...
  }: {
    hardware.graphics.enable = lib.mkDefault true;

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        protontricks.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      er-patcher

      prismlauncher
      cockatrice
      r2modman
    ];
  };
}
