{
  config,
  pkgs,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    (./. + "/machines" + ("/" + systemSettings.machine) + "/boot.nix")
    (./. + "/machines" + ("/" + systemSettings.machine) + "/hardware-configuration.nix")
    #../../system/bluetooth.nix
    #../../system/networking.nix
    #../../system/sound.nix
    #../../system/steam.nix
  ];

  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

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
  #users.defaultUserShell = pkgs.zsh;
  #programs.zsh.enable = true;
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
    lf

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

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
  };

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
