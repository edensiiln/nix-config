{
  description = "Eden's system flake";

  inputs = {
    #core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #structural
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    #misc
    nix-colors.url = "github:misterio77/nix-colors";
    minecraft-servers.url = "github:mkaito/nixos-modded-minecraft-servers";
    
    tagstudio = {
      url = "github:TagStudioDev/TagStudio";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ftlman = {
      url = "github:afishhh/ftlman";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #godot461.url = "github:nixos/nixpkgs/7bfffc846d13cf0368a0c59c72f821fd916824d1"; #godot 4.6.1

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      (inputs.import-tree ./modules)
      #inputs.nvf.nixosModules.default
    ];
  };
}
