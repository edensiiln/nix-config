{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {
    pkgs,
    lib,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.edenNiri;
    };
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.edenNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.edenNoctalia)
          (lib.getExe pkgs.kanshi)
          (lib.getExe pkgs.discord)
          (lib.getExe self'.packages.edenNordvpn)
        ];

        spawn-sh-at-startup = [
          "wl-clipboard-history -t"
          "wl-paste --watch cliphist store"
          "rm $HOME/.cache/cliphist/db"
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us,ua";

        layout.gaps = 5;

        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
          "Mod+Q".close-window = null;
          "Mod+S".spawn-sh = "${lib.getExe self'.packages.edenNoctalia} ipc call launcher toggle";
        };
      };
    };
  };
}
