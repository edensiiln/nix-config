{
  lib,
  config,
  ...
}:
{
  options = {
    kanshiModule.enable = lib.mkEnableOption "enable kanshi";
  };

  config = lib.mkIf config.kanshiModule.enable {
    services.kanshi = {
      enable = true;
      systemdTarget = "hyprland-session.target";
    
      settings = [
        {
          profile.name = "main";
          profile.outputs = [
            {
              criteria = "DP-1";
              position = "0,0";
              mode = "1920x1080@60Hz";
              transform = "90";
            }
            {
              criteria = "HDMI-A-1";
              position = "1080,840";
              mode = "1920x1080@60Hz";
            }
            {
              criteria = "DP-3";
              position = "3000,840";
              mode = "1920x1080@60Hz";
            }
          ];
        }
      ];
    };
  };
}
