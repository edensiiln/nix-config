{ self, inputs, ... }: {

  flake.nixosModules.edenLaptopConfiguration = { pkgs, lib, ... }: {
    
    imports = [
      self.nixosModules.edenLaptopHardware
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  };

}
