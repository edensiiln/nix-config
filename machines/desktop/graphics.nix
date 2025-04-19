{}:
{
  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;
      
      open = false;
      
      nvidiaSettings = true;
      
      #package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

}
