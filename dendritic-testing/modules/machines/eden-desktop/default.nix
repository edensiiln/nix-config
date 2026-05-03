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
}
