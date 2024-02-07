{ config, pkgs, ...}:
let
background = ./../backgrounds/pink-clouds.png;
init = ''
 #!/usr/bin/env bash
  sww init &
  sww img ${background} &
  nm-applet --indicator &
  waybar &
  mako
'';
in
{
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1"; # if your cursor becomes invisible
    NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar # status bar
    mako # notification daemon
    libnotify
    swww # wallpaper daemon
    rofi-wayland
    grim # screenshots
    slurp # screenshots
    networkmanagerapplet
    ];

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
	  --time \
          --asterisks \
	  --user-menu \
	  --cmd ${init} 
      '';
    };
  };

  environment.etc."greetd/environments".text = ''
    hyprland
  '';

  xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
