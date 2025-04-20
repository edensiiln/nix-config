{
  description = "Siiln's flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nix-colors.url = "github:misterio77/nix-colors";
    minecraft-servers.url = "github:mkaito/nixos-modded-minecraft-servers";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${systemSettings.system};

    # ~~~ SYSTEM SETTINGS ~~~ #
    systemSettings = {
      profile = "main"; # main, laptop, homelab
      machine = "thinkpad"; # desktop, thinkpad, homelab

      # DEFAULTS
      system = "x86_64-linux";
      hostname = "eden";
      timezone = "America/Chicago";
      locale = "en_US.UTF-8";

      # OVERRIDES
      desktop = {
        #hostname = "eden";
      };
      thinkpad = {
        #hostname = "eden";
      };
      homelab = {
        hostname = "arkserver";
      };
    };

    # ~~~ USER SETTINGS ~~~ #
    userSettings = {
      theme = "eden";

      # DEFAULTS
      username = "eden";
      name = "Eden";
      #dotfilesDir = "~/.dotfiles";
      #wm = "hyprland";
      #browser = "floorp";
      term = "alacritty";
      editor = "nvim";

      # OVERRIDES
      main = {};
      laptop = {};
      homelab = {
        username = "arkserver";
        name = "arkserver";
      };
    };
  in {
    nixosConfigurations.${systemSettings.${systemSettings.machine}.hostname or systemSettings.hostname} = lib.nixosSystem {
      system = systemSettings.system;
      specialArgs = {
        systemSettings = systemSettings // systemSettings.${systemSettings.machine};
        userSettings = userSettings // userSettings.${systemSettings.profile};
        inherit inputs;
      };
      modules = [
        (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
      ];
    };

    homeConfigurations.${userSettings.${systemSettings.profile}.username or userSettings.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        systemSettings = systemSettings // systemSettings.${systemSettings.machine};
        userSettings = userSettings // userSettings.${systemSettings.profile};
        inherit inputs;
      };
      modules = [
        (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
        (./. + "/themes" + ("/" + userSettings.theme) + ".nix")
      ];
    };
  };
}
