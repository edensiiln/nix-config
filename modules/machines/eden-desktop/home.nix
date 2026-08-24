{ self, inputs, ... }: {
  flake.homeConfigurations.eden = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.edenHome
      {
        home.username = "eden";
	home.homeDirector = "/home/eden";
      }
    ];
  };

  flake.homeModules.edenHome = { pkgs, ... }: {
    imports = [
      self.homeModules.edenShells
    ];

    home.stateVersion = "23.11";
  };
}
