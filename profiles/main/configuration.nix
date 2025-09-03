{
  pkgs,
  lib,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    (../.. + "/machines" + ("/" + systemSettings.machine) + "/default.nix")
    ../../system
  ];

  # CUSTOM MODULES
  hyprlandModule.enable = true;
  bluetoothModule.enable = true;
  soundModule.enable = true;
  steamModule.enable = true;


  hardware.graphics.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.partition-manager.enable = true;
  
  # THUNAR
  programs.thunar.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  programs.xfconf.enable = true; # prefrence changes discarded without

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin # Requires an Archive manager like file-roller, ark, etc
    thunar-volman # automatic management of removable drives and media
  ];

  #virtualisation.waydroid.enable = true;

  # SHELLS
  #environment.shells = with pkgs; [ zsh nushell ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  #programs.nushell.enable = true;

  environment.systemPackages = with pkgs; [
    # text editors
    vim
    neovim

    # terminal
    starship
    nushell
    zellij
    btop
    neofetch
    ranger
    yazi

    # rust
    rustup
    rustc
    cargo

    # tools
    wget
    unzip
    man # info
    tldr # info
    libqalculate # calculator
    ntfs3g
    xorg.xhost
    docker
    ffmpeg

    prismlauncher
    cockatrice

    kdePackages.ark # file archiver used by thunar
  ];

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["networkmanager" "wheel"];
    #shell = pkgs.nushell;
    #packages = with pkgs; [];
  };

  programs.nix-ld.enable = true;
  #programs.nix-ld.libraries = with pkgs; [];

  programs.ssh.startAgent = true;

  # OpenSSH daemon
  services.openssh.enable = true;

  system.stateVersion = "23.11"; # don't change unless you know what you're doing
}
