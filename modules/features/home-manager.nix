{ self, inputs, ... }: {
  flake.nixosModules.edenHomeManager = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.default
    ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
