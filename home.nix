{ config, pkgs, ... }:
let 
  shellAliases = {
    nixsw = "sudo nixos-rebuild switch";
    nixswf = "sudo nixos-rebuild switch --flake";
    nixswd = "sudo nixos-rebuild switch --flake ~/.dotfiles";

    ns = "sudo nixos-rebuild switch";
    nsf = "sudo nixos-rebuild switch --flake";
    nsd = "sudo nixos-rebuild switch --flake ~/.dotfiles";

    homesw = "home-manager switch";
    homeswf = "home-manager switch --flake";
    homeswd = "home-manager switch --flake ~/.dotfiles";
    
    hs = "home-manager switch";
    hsf = "home-manager switch --flake";
    hsd = "home-manager switch --flake ~/.dotfiles";

    s = "sudo";
    ":q" = "exit";
    #cd = "z";
    #zz = "z -";

    cargo = "cargo mommy";

    yta-aac = "yt-dlp --extract-audio --audio-format aac";
    yta-best = "yt-dlp --extract-audio --audio-format best";
    yta-flac = "yt-dlp --extract-audio --audio-format flac";
    yta-mp3 = "yt-dlp --extract-audio --audio-format mp3";
    ytv-best = "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4";
  };
in
{
  programs.home-manager.enable = true;
  home.username = "eden";
  home.homeDirectory = "/home/eden";

  home.stateVersion = "23.11"; # don't change unless you know what you're doing

  nixpkgs.config.allowUnfree = true;

  # Shells
  programs.bash = {
    enable = true;
    inherit shellAliases;
  };
  programs.zsh = {
    enable = true;
    inherit shellAliases;
  };
  programs.nushell = {
    enable = true;
    shellAliases = shellAliases // {
      cat = "bat";
    };
    extraConfig = ''
      $env.config = {
        show_banner: false
      }
    '';
  };

  # Shell Prompt
  programs.starship = {
    enable = true;
    settings = {
    };
  };

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
    polybar
    headsetcontrol
    firefox
    floorp
    discord
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
  };

  
}
