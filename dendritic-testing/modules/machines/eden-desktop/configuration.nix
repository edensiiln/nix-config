{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.edenDesktopConfiguration = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.edenDesktopHardware
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
