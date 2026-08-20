{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.edenBrowsers = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      floorp-bin
      ungoogled-chromium
      tor-browser 
    ];  
  };

  flake.nixosModules.edenDesktop = { pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.system}";
  in {
    imports = [
      self.nixosModules.edenGtk
      self.nixosModules.edenBrowsers
      self.nixosModules.edenNiri
      self.nixosModules.edenSound
      self.nixosModules.edenNetworking
    ];
    
    #programs.niri.enable = true;
    #programs.niri.package = selfpkgs.edenNiri;
    
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;

  };
}
