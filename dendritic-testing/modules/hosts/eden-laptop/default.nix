{self, inputs, ...}: {
  
  flake.nixosConfigurations.eden-laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.edenLaptopConfiguration
    ];
  };
}
