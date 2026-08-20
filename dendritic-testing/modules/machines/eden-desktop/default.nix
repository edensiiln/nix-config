{
  self,
  inputs,
  ...
}: let
  timezone = "America/Chicago";
  locale = "en_US.UTF-8";
in {
  flake.nixosConfigurations.eden = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.edenTower
      self.nixosModules.edenHomeManager
    ];
  };

  flake.nixosModules.edenTower = { pkgs, ... }: {
    imports = [
      self.nixosModules.edenDisplay
      
      self.nixosModules.edenDesktop

      self.nixosModules.edenGaming

      self.nixosModules.edenNix
      self.nixosModules.edenGit
      self.nixosModules.openrgb

      inputs.home-manager.nixosModules.default
      #inputs.home-manager.flakeModules.home-manager
    ];
    
    networking.hostName = "eden";

    users.users.eden = {
      isNormalUser = true;
      description = "Eden Azalea Haven";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.eden = self.homeModules.edenHome;

    #users.users.siiln = {
      #isNormalUser = true;
      #description = "Siiln System";
      #extraGroups = ["networkmanager" "wheel"];
    #};
    #home-manager.users.siiln = self.homeModules.siilnModule;

    users.groups.nordvpn.members = ["eden"];
    #users.groups.nordvpn.members = ["eden" "siiln"];

      #config = {
      time.timeZone = timezone;
      i18n.defaultLocale = locale;
      i18n.extraLocaleSettings = {
        LC_ADDRESS = locale;
        LC_IDENTIFICATION = locale;
        LC_MEASUREMENT = locale;
        LC_MONETARY = locale;
        LC_NAME = locale;
        LC_NUMERIC = locale;
        LC_PAPER = locale;
        LC_TELEPHONE = locale;
        LC_TIME = locale;
      };
    #};

    fonts.packages = with pkgs; [
      nerd-fonts._0xproto
      nerd-fonts.droid-sans-mono
      nerd-fonts.symbols-only
      font-awesome
      powerline-fonts
      powerline-symbols
    ];
    
    nix.settings.experimental-features = ["nix-command" "flakes"];
    system.stateVersion = "23.11";

  };

}
