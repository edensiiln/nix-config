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
          on-click = "pavucontrol";
	};
	clock = {
          format = "{:%H:%M%n%m/%d}";
	  tooltip-format = "{:%c}";
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
    '';
  };
}
