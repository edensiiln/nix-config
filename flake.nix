{
  description = "Siiln's flake";

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      # ~~~ SYSTEM SETTINGS ~~~ #
      systemSettings = {
	
	#desktop = {
        #  system = "x86_64-linux";
	#  hostname = "eden";
        #  timezone = "America/Chicago";
        #  locale = "en_US.UTF-8";
	#};

	#thinkpad = {
        #  system = "x86_64-linux";
	#  hostname = "eden";
        #  timezone = "America/Chicago";
        #  locale = "en_US.UTF-8";
	#};
	
	homelab = {
          system = "x86_64-linux";
      	  hostname = "arkserver";
          timezone = "America/Chicago";
          locale = "en_US.UTF-8";
	};
      
        system = "x86_64-linux";
	hostname = "eden";
	profile = "main"; # main, homelab, laptop
	machine = "desktop"; # desktop, thinkpad, arkserver
	timezone = "America/Chicago";
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
	editor = "nvim";
      };

    in {

    nixosConfigurations = {
      eden = lib.nixosSystem {
       system = systemSettings.system;
       #modules = [ ./configuration.nix ];
       modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix") ];
       specialArgs = {
         inherit systemSettings;
         inherit userSettings;
       };
      };
    };

    homeConfigurations = {
      eden = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = {
  	  inherit systemSettings;
          inherit userSettings;
	};
	#modules = [ ./home.nix ];
        modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix") ];
      };
    };

  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    nixvim = {
      url = "github:dc-tec/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

}
