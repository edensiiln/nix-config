# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/nvme0n1";
    useOSProber = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.lightdm.enable = true;
    windowManager.leftwm.enable = true;
    #libinput.enable = true; # Touchpad
  };

  services.xrdp.enable = true;
  services.xrdp.openFirewall = true;

  # Wayland
  #services.xserver.enable = false;
  #programs.sway.enable = true;

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

    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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
    rustup
    rustc
    cargo
    unzip
    man
    tldr
    libqalculate
    ntfs3g
  ];
  
  users.users.eden = {
    isNormalUser = true;
    description = "eden";
    extraGroups = [ "networkmanager" "wheel" ];
    #shell = pkgs.nushell;
    packages = with pkgs; [];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  #nixpkgs.config.permittedInsecurePackages = [
  #  "electron-25.9.0"
  #];
  
  #xdg.portal.enable = true;
  #services.flatpak.enable = true;

  # OpenSSH daemon
  # services.openssh.enable = true;

  # Firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  system.stateVersion = "23.11"; # don't change unless you know what you're doing
}
