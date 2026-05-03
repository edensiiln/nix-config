{
  lib,
  config,
  ...
}: {
  options = {
    hypridleModule.enable = lib.mkEnableOption "enable hypridle";
  };

  config = lib.mkIf config.hypridleModule.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
        ];
      };
    };
  };
}
