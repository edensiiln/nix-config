{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    RDClientModule.enable = lib.mkEnableOption "enable remote desktop client";
  };

  config = lib.mkIf config.RDClientModule.enable {
    environment.systemPackages = with pkgs; [
      freerdp
    ];
  };
}
