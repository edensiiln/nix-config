{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.edenLaptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.edenLaptopConfiguration
    ];
  };
}
