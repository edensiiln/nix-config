{
  description = "Siiln's flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-colors.url = "github:misterio77/nix-colors";
    minecraft-servers.url = "github:mkaito/nixos-modded-minecraft-servers";
    nixvim = {
      url = "github:dc-tec/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      # ~~~ SYSTEM SETTINGS ~~~ #
      systemSettings = {

	system = "x86_64-linux";
	hostname = "eden";
	timezone = "America/Chicago";
	locale = "en_US.UTF-8";

	desktop = {
          system = "x86_64-linux";
	  hostname = "eden";
          timezone = "America/Chicago";
          locale = "en_US.UTF-8";
	};

	thinkpad = {
          system = "x86_64-linux";
	  hostname = "eden";
          timezone = "America/Chicago";
          locale = "en_US.UTF-8";
	};
	
	homelab = {
          system = "x86_64-linux";
      	  hostname = "arkserver";
          timezone = "America/Chicago";
          locale = "en_US.UTF-8";
	};

 	profile = "main"; # main, homelab, laptop
	machine = "desktop"; # desktop, thinkpad, arkserver
	
	
        
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
	
	theme = "malat";

	homelab = {
          username = "arkserver";
	  name = "arkserver";
	};
      };

    in {

    nixosConfigurations = 
    if systemSettings.profile == "main" then {
      eden = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./profiles/main/configuration.nix ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
	  inherit inputs;
        };
      };
    } else if systemSettings.profile == "laptop" then {
      eden = lib.nixosSystem {
        system = "x86_64-linux";
	modules = [ ./profiles/main/configuration.nix ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
	  inherit inputs;
        };
      };
    } else if systemSettings.profile == "homelab" then {
      arkserver = lib.nixosSystem {
        system = "x86_64-linux";
	modules = [ ./profiles/homelab/configuration.nix ];
        specialArgs = {
          systemSettings = (systemSettings // systemSettings.homelab);
          userSettings = (userSettings // userSettings.homelab);
	  inherit inputs;
	};
      };
    } else
      abort "systemSettings.profile is invalid";

    #nixosConfigurations = {
    #  eden = lib.nixosSystem {
    #    system = systemSettings.system;
    #    #modules = [ ./configuration.nix ];
    #    modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix") ];
    #    specialArgs = {
    #      #inherit SystemSettings;
    #      systemSettings == (systemSettings // systemSettings.profile);
    #      #inherit userSettings;
    #      userSettings == (userSettings // userSettings.profile);
    #    };
    #  };
    #};

    homeConfigurations =
    if systemSettings.profile == "main" then {
      eden = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = {
  	  inherit systemSettings;
          inherit userSettings;
	  inherit inputs;
	};
	#modules = [ ./home.nix ];
        modules = [
	  (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix")
          (./. + "/themes"+("/"+userSettings.theme)+".nix")
	];
      };
    } else if systemSettings.profile == "laptop" then {
      eden = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = {
  	  inherit systemSettings;
          inherit userSettings;
	  inherit inputs;
	};
	#modules = [ ./home.nix ];
        modules = [
	  (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix")
          (./. + "/themes"+("/"+userSettings.theme)+".nix")
	];
      };
    } else if systemSettings.profile == "homelab" then {
      arkserver = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = {
          systemSettings = (systemSettings // systemSettings.homelab);
          userSettings = (userSettings // userSettings.homelab);
	  inherit inputs;
	};
	#modules = [ ./home.nix ];
        modules = [
	  (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix")
          (./. + "/themes"+("/"+userSettings.theme)+".nix")
	];
      };
    } else
      abort "systemSettings.profile is invalid";
  };

}
