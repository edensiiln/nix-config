{
  pkgs,
  lib,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    (../.. + "/machines" + ("/" + systemSettings.machine) + "/default.nix")
    ../../system/wm/hyprland.nix
    ../../system/default.nix
  ];

  # custom modules
  bluetoothModule.enable = true;
  nvidiaDriversModule.enable = systemSettings.machine == "desktop";
  soundModule.enable = true;
  steamModule.enable = true;

  hardware.graphics.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.partition-manager.enable = true;

  services.gvfs.enable = true;

  # Shells
  #environment.shells = with pkgs; [ zsh nushell ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  #programs.nushell.enable = true;

  environment.systemPackages = with pkgs; [
    # text editors
    vim
    neovim

    # git
    git
    gitui

    # terminal
    starship
    nushell
    zellij
    btop
    neofetch
    ranger

    # rust
    rustup
    rustc
    cargo

    # tools
    wget
    unzip
    man
    tldr
    libqalculate
    ntfs3g
    xorg.xhost
    docker

    prismlauncher
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
