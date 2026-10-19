{
  self,
  inputs,
  lib,
  pkgs,
  ...
}: {
  flake.nixosModules.edenDisplay = {
    pkgs,
    lib,
    ...
  }: {
    
    environment.systemPackages = [ pkgs.kanshi ];

    #services.xserver.displayManager.setupCommands = lib.getExe self.packages."${pkgs.system}".edenKanshi;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    #systemd.services.kanshi = {
    #description = "kanshi daemon";
    #wantedBy = [ "display-manager.service" ];
    #after = [ "display-manager.service" ];
    #serviceConfig = {
    #  Type = "simple";
    #  ExecStart = "${pkgs.kanshi}/bin/kanshi -c /home/eden/.config/kanshi/config";
    #  Restart = "on-failure";
    #  RestartSec = 3;
    #  User = "sddm";
    #};
  #};
};

  flake.homeModules.edenKanshi = {
    pkgs,
    lib,
    ...
  }: {
    services.kanshi = {
      enable = true;
      #systemdTarget = "";
      #extraConfig = ''
      #  profile main {
      #    output DP-1 position 0,0 mode 1920x1080@60Hz transform 90
      #    output HDMI-A-1 position 1080,840 mode 1920x1080@60Hz
      #    output DP-3 position 3000,840 mode 1920x1080@60Hz
      #  }
      #'';
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
