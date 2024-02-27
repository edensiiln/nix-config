{
  description = "Siiln's flake";

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      # ~~~ SYSTEM SETTINGS ~~~ #
      systemSettings = {
        system = "x86_64-linux";
	hostname = "eden";
	machine = "thinkpad";
	timezone = "America/New_York";
	locale = "en_US.UTF-8";
      };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};

      # ~~~ USER SETTINGS ~~~ #
      userSettings = {
        username = "eden";
	name = "Eden";
	#dotfilesDir = "~/.dotfiles";
	#wm = "hyprland";
	#browser = "floorp";
	term = "alacritty";
	editor = "neovim";
      };

    in {

    nixosConfigurations = {
      nixos = lib.nixosSystem {
       system = systemSettings.system;
       modules = [ ./configuration.nix ];
       specialArgs = {
         inherit systemSettings;
         inherit userSettings;
       };
      };
    };

    homeConfigurations = {
      eden = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	modules = [ ./home.nix ];
      };
    };

  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

}
