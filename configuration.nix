{ config, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    #./machines/desktop/hardware-configuration.nix
    ( ./. + "/machines"+("/"+systemSettings.machine)+"/hardware-configuration.nix")
    #./x11.nix
    #./sway.nix
    ./system/wm/hyprland.nix
  ];

  boot.loader = if (systemSettings.machine == "desktop") then {
    lib.warn "using grub"
    grub = {
      enable = true;
      device = "/dev/nvme0n1";
      useOSProber = true;
    };
  }
  else {
    lib.warn "using systemd-boot"
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = systemSettings.hostname;
    networkmanager.enable = true;
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Shells
  #environment.shells = with pkgs; [ zsh nushell ];
  #users.defaultUserShell = pkgs.zsh;
  #programs.zsh.enable = true;
  #programs.nushell.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    git
    gitui
    starship
    nushell
    zellij
    btop
    neofetch
    ranger
    lf
    rustup
    rustc
    cargo
    unzip
    man
    tldr
    libqalculate
    ntfs3g
    xorg.xhost
  ];
  
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    #shell = pkgs.nushell;
    packages = with pkgs; [];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    
  ];

  programs.ssh.startAgent = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
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
