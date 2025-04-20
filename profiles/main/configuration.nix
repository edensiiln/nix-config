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

  services.xrdp.enable = true;
  services.xrdp.openFirewall = true;

  #services.polybar.enable = true;
  services.printing.enable = true;

  # Polkit
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

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

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
    font-awesome
    powerline-fonts
    powerline-symbols
  ];

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["networkmanager" "wheel"];
    #shell = pkgs.nushell;
    packages = with pkgs; [];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];

  programs.ssh.startAgent = true;

  #xdg.portal.enable = true;

  #services.flatpak.enable = true;

  # OpenSSH daemon
  services.openssh.enable = true;

  # Firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  system.stateVersion = "23.11"; # don't change unless you know what you're doing
}
