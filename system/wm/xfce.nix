{
  lib,
  config,
  pkgs,
  callPackage,
  ...
}: {

  options = {
    xfceModule.enable = lib.mkEnableOption "enable xfce";
  };

  config = lib.mkIf config.xfceModule.enable {
    services.xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
    services.displayManager.defaultSession = "xfce";
    #services.greetd = {
    #  enable = true;
    #  settings = {
    #    default_session.command = ''
    #           ${pkgs.greetd.tuigreet}/bin/tuigreet \
    #      --time \
    #      --asterisks \
    #      --user-menu \
    #      --xsession-wrapper xfce
    #    '';
    #   };
    #};
    #environment.etc."greetd/environments".text = ''
    #  startxfce4
    #  zsh
    #'';
    #
    ## https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    #systemd.services.greetd.serviceConfig = {
    #  Type = "idle";
    #  StandardInput = "tty";
    #  StandardOutput = "tty";
    #  StandardError = "journal"; # Without this errors will spam on screen
    #  # Without these bootlogs will spam on screen
    #  TTYReset = true;
    #  TTYVHangup = true;
    #  TTYVTDisallocate = true;
    #};
  };
}
