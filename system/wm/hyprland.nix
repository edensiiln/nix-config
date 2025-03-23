{ config, pkgs, ...}:
#let
#background = ./../backgrounds/pink-clouds.png;
#init = ''
# #!/usr/bin/env bash
#  sww init &
#  sww img ${background} &
#  nm-applet --indicator &
#  waybar &
#  mako
#'';
#in
{
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
	  --time \
          --asterisks \
	  --user-menu \
	  --cmd Hyprland
      '';
    };
  };
  environment.etc."greetd/environments".text = ''
    hyprland
  '';

  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # if your cursor becomes invisible
    NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
  };

  hardware = {
    opengl.enable = true;
    #graphics.enable = true;

    nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;

      nvidiaSettings = true;

      #package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  environment.systemPackages = with pkgs; [
    waybar # status bar
    mako # notification daemon
    libnotify
    #swww # wallpaper daemon
    hyprpaper #wallpaper daemon
    wofi
    rofi-wayland
    wl-clipboard
    cliphist
    grim # screenshots
    slurp # screenshots
    networkmanagerapplet
    ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
