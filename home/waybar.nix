{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
	modules-right = [
	  "tray"
          "pulseaudio"
	  "battery"
	  "clock"
	];
	
	pulseaudio = {
          format = "{icon}";
          format-muted = "";
          format-bluetooth = "{icon}";
          format-bluetooth-muted = " {icon}";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
	  on-scroll-up = "pamixer -i 1";
	  on-scroll-down = "pamixer -d 1";
	  tooltip-format = "Volume {volume}%";
        };

	clock = {
          format = "{:%R%n%m/%d}";
	  tooltip-format = "{:%a %b %d%n%Y}";
	};

      };
    };
    style = ''
      * {
          border: none;
	  border-radius: 0;
          font-size: 12px;
	  margin: 0px;
	  padding: 0 4px;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 10px;
        background: transparent;
        color: #cdd6f4;
      }
      
      #workspaces button.focused {
        background: #585b70;
      }

    '';
  };
}
