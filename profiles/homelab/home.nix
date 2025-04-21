{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home/sh.nix
  ];

  programs.home-manager.enable = true;
  home.username = "arkserver";
  home.homeDirectory = "/home/arkserver";

  home.stateVersion = "23.11"; # don't change unless you know what you're doing

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    yt-dlp
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.file.".config/ranger/rc.conf".source = ../../.config/ranger/rc.conf;
  home.file.".config/ranger/rifle.conf".source = ../../.config/ranger/rifle.conf;
  home.file.".config/ranger/scope.sh" = {
    source = ../../.config/ranger/scope.sh;
    executable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";

    #RANGER_LOAD_DEFAULT_RC = "FALSE";
  };
}
