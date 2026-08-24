{ inputs, ...}: {
  flake.nixosModules.edenNix = {pkgs, ...}: {
    
    nix.settings.experimental-features = ["nix-command" "flakes"];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      nil
      nixd
      statix
      alejandra
      manix
      nix-inspect
    ];

    programs.yazi.enable = true;

  };
}
