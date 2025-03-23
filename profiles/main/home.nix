{ config, pkgs, inputs, ... }:
{
  imports = [
    ../../sh.nix
    ../../home/hyprland.nix
    ../../home/waybar.nix
    inputs.nix-colors.homeManagerModules.default
    ../../features/alacritty.nix
  ];

  programs.home-manager.enable = true;
  home.username = "eden";
  home.homeDirectory = "/home/eden";

  home.stateVersion = "23.11"; # don't change unless you know what you're doing

  nixpkgs.config.allowUnfree = true;

  colorscheme = inputs.nix-colors.colorSchemes.tokyo-night-storm;

  # Terminal Emulators

  home.packages = with pkgs; [
    #polybar
    headsetcontrol
    firefox
    floorp
    libreoffice
    discord
    webcord
    obsidian
    github-desktop
    godot_4
    alacritty
    kitty
    xfce.thunar
    rofi
    mpv
    vlc
    maim
    yt-dlp
    cargo-mommy
    bat
    z-lua
    gparted
    pavucontrol
    pragha
    sxiv
    wlr-randr
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
  
  home.sessionVariables = {
    EDITOR = "nvim";

    #RANGER_LOAD_DEFAULT_RC = "FALSE";

    #CARGO_MOMMYS_ROLES = "Miss/Miss/Miss/Miss/Mommy";
    #CARGO_MOMMYS_PRONOUNS = "her/her/her/its";
    #CARGO_MOMMYS_LITTLE = "doll/doll/doll/puppy/puppy/girl";
    CARGO_MOMMYS_ROLES = "Director/Handler/Mx./Mx. Diana";
    CARGO_MOMMYS_PRONOUNS = "her";
    CARGO_MOMMYS_LITTLE = "Weapon/Asset/Knife/doll";
    CARGO_MOMMYS_MOODS = "ominous";
  };

  
}
