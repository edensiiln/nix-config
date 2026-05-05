{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.edenDesktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.edenDesktopConfiguration
    ];
  };

  flake.nixosModules.edenDesktopModule = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    users.users.eden = {
      isNormalUser = true;
      description = "Eden Azalea Haven";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.eden = self.homeModules.edenModule;

    users.users.siiln = {
      isNormalUser = true;
      description = "Siiln System";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.siiln = self.homeModules.siilnModule;

    environment.systemPackages = [];

    users.groups.nordvpn.members = ["eden" "siiln"];

  };

  flake.homeModules.edenModule = { pkgs, ... }: {
    programs.bash.enable = true;

    home.packages = [ ];
    home.stateVersion = "24.11";
  };

}
