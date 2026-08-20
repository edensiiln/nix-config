{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.edenDisplay = {
    pkgs,
    lib,
    ...
  }: {
    #services.xserver.displayManager.setupCommands = lib.getExe self.packages."${pkgs.system}".edenKanshi;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  flake.nixosModules.edenKanshi = {
    pkgs,
    lib,
    ...
  }: {
    services.kanshi = {
      enable = true;
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
