{self, inputs, ...}: {
  
  flake.nixosConfigurations.eden-desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.edenDesktopConfiguration
    ];
  };
}
