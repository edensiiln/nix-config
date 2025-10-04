{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../home
  ];

  # CUSTOM MODULES
  alacrittyModule.enable = true;
  gitModule.enable = true;
  #nvfModule.enable = true;

  # HYPRLAND
  hyprlandModule.enable = true;
  hyprpaperModule.enable = true;
  kanshiModule.enable = true;
  waybarModule.enable = true;


  programs.home-manager.enable = true;
  home.username = "eden";
  home.homeDirectory = "/home/eden";

  home.stateVersion = "23.11"; # don't change unless you know what you're doing

  nixpkgs.config.allowUnfree = true;

  # Terminal Emulators

  home.packages = with pkgs; [
    headsetcontrol
    firefox
    floorp-bin
    libreoffice

    discord
    #webcord
    revolt-desktop

    obsidian
    github-desktop
    godot

    kitty
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
    #] ++ [
    #inputs.tagstudio.packages.${pkgs.stdenv.hostPlatform.system}.tagstudio
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  home.file = {
    ".config/ranger/rc.conf".source = ../../.config/ranger/rc.conf;
    ".config/ranger/rifle.conf".source = ../../.config/ranger/rifle.conf;
    ".config/ranger/scope.sh" = {
      source = ../../.config/ranger/scope.sh;
      executable = true;
    };
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
    EDITOR = "nvim";

    CARGO_MOMMYS_ROLES = "Director/Handler/Mx./Mx. Diana";
    CARGO_MOMMYS_PRONOUNS = "her";
    CARGO_MOMMYS_LITTLE = "Weapon/Asset/Knife/doll";
    CARGO_MOMMYS_MOODS = "ominous";
  };

}
