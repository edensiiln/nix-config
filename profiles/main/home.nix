{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../home/alacritty.nix
    ../../home/hyprland.nix
    ../../home/kanshi.nix
    ../../home/nvf.nix
    ../../home/sh.nix
    ../../home/waybar.nix
  ];

  programs.home-manager.enable = true;
  home.username = "eden";
  home.homeDirectory = "/home/eden";

  home.stateVersion = "23.11"; # don't change unless you know what you're doing

  nixpkgs.config.allowUnfree = true;

  # Terminal Emulators

  home.packages = with pkgs; [
    headsetcontrol
    firefox
    floorp
    libreoffice
    discord
    webcord
    obsidian
    github-desktop
    #godot_4
    alacritty
    kitty
    xfce.thunar
    mpv
    vlc
    #maim
    yt-dlp
    cargo-mommy
    bat
    z-lua
    gparted
    pavucontrol
    pamixer
    pragha
    sxiv
    wlr-randr
    imagemagick
    swappy
    #udiskie
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
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

  #services.udiskie = {
  #  enable = true;
  #  settings.program_options.file_manager = "${pkgs.xfce.thunar}/bin/thunar";
  #};

  home.sessionVariables = {
    EDITOR = "nvim";

    #RANGER_LOAD_DEFAULT_RC = "FALSE";

    CARGO_MOMMYS_ROLES = "Director/Handler/Mx./Mx. Diana";
    CARGO_MOMMYS_PRONOUNS = "her";
    CARGO_MOMMYS_LITTLE = "Weapon/Asset/Knife/doll";
    CARGO_MOMMYS_MOODS = "ominous";
  };
}
