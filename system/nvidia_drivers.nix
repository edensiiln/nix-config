{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nvidiaDriversModule.enable = lib.mkEnableOption "enable nvidia drivers";
  };

  config = lib.mkIf config.nvidiaDriversModule.enable {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;

      nvidiaSettings = true;

      #package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
