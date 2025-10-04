{
  lib,
  config,
  pkgs,
  ...
}: {

  options = {
    hyprlandModule.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.hyprlandModule.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session.command = ''
               ${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd Hyprland
        '';
      };
    };
    environment.etc."greetd/environments".text = ''
      hyprland
      zsh
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

    environment.systemPackages = with pkgs; [
      waybar # status bar
      mako # notification daemon
      libnotify
      hyprpaper # wallpaper daemon
      wofi
      rofi
      wl-clipboard
      cliphist
      grim # screenshots
      slurp # screenshots
      networkmanagerapplet
      hyprpolkitagent
    ];

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
