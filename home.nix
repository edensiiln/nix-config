{ config, pkgs, ... }:
{
  imports = [
    ./sh.nix
    ./home/hyprland.nix
    ./home/waybar.nix
  ];

  programs.home-manager.enable = true;
  home.username = "eden";
  home.homeDirectory = "/home/eden";

  home.stateVersion = "23.11"; # don't change unless you know what you're doing

  nixpkgs.config.allowUnfree = true;

  # Terminal Emulators
  programs.alacritty = {
    enable = true;
    settings = {
      shell = "nu";
      colors = {
        primary = {
          foreground = "#a9b1d6";
          background = "#1a1b26";
        };
	normal = {
	  black = "#32344a";
	  red = "#f7768e";
	  green = "#9ece6a";
	  yellow = "#e0af68";
	  blue = "#7aa2f7";
	  magenta = "#ad8ee6";
	  cyan = "#449dab";
	  white = "#787c99";
	};
	bright = {
	  black = "#444b6a";
	  red = "#ff7a93";
	  green = "#b9f27c";
	  yellow = "#ff9e64";
	  blue = "#7da6ff";
	  magenta = "#bb9af7";
	  cyan = "#0db9d7";
	  white = "#acb0d0";
	};
      };
    };
  };

  home.packages = with pkgs; [
    #polybar
    headsetcontrol
    firefox
    floorp
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/eden/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    CARGO_MOMMYS_ROLES = "Miss/Miss/Miss/Miss/Mommy";
    CARGO_MOMMYS_PRONOUNS = "her/her/her/its";
    CARGO_MOMMYS_LITTLE = "doll/doll/doll/puppy/puppy/girl";
    #CARGO_MOMMYS_ROLES = "Director/Handler/Mx./Mx. Ecila";
    #CARGO_MOMMYS_PRONOUNS = "her";
    #CARGO_MOMMYS_LITTLE = "Weapon/Weapon/Knife/doll";
  };

  
}
