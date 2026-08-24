{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    printingModule.enable = lib.mkEnableOption "enable printing";
  };

  config = lib.mkIf config.printingModule.enable {
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
