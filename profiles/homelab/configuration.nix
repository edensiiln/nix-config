{
  pkgs,
  #lib,
  userSettings,
  #inputs,
  ...
}: {
  imports = [
    ../../machines/arkserver
    ../../system
    ../../programs/minecraft-servers.nix
  ];

  # custom modules
  xfceModule.enable = true;
  plexModule.enable = true;

  hardware.graphics.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    #git
    #gitui
    starship
    nushell
    zellij
    btop
    neofetch
    ranger
    rustup
    rustc
    cargo
    unzip
    man
    tldr
    libqalculate
    ntfs3g
    xorg.xhost
    docker

    godns
    temurin-bin-21
    tmux
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
