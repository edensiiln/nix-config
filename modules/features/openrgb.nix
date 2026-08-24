{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.openrgb = {
    pkgs,
    ...
  }: {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb;
    };
  };
}
