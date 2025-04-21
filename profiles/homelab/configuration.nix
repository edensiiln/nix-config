{ pkgs, lib, userSettings, inputs, ... }:
{
  imports = [
    ../../machines/arkserver/hardware-configuration.nix
    ../../machines/arkserver/boot.nix
    ../../system/networking.nix
    ../../system/locale.nix
    ../../programs/minecraft-servers.nix
  ];

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
    xorg.xhost
    docker
    godns
    temurin-bin-21
    tmux
  ];

  fonts.packages = with pkgs; [
   nerdfonts
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
