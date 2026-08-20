{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.edenNiri = {
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
            #(lib.getExe self'.packages.edenKanshi)
            #(lib.getExe pkgs.discord)
            #(lib.getExe pkgs.dunst)
            #(lib.getExe self'.packages.edenNordvpn)
        ];

        spawn-sh-at-startup = [
          "wl-clipboard-history -t"
          "wl-paste --watch cliphist store"
          "rm $HOME/.cache/cliphist/db"
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us,jp,cn";

        layout.gaps = 5;

        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
            "Mod+Q".close-window = _: { };
            "Mod+S".spawn-sh = "${lib.getExe self'.packages.edenNoctalia} ipc call launcher toggle";
        };
      };
    };#.override {
     #   libdisplay-info = libdisplay-info.overrideAttrs (finalAttrs: {
     #     version = "0.3.0";
#	  src = fetchFromGitLab {
#            domain = "gitlab.freedesktop.org";
#	    owner = "emersion";
#	    repo = "libdisplay-info";
#	    rev = finalAttrs.version;
#	    sha256 = "sha-256nXf2KGovNKvcch1H1zKBkAOeySMJgxMpbi5z9gLrdc=";
#	  };
#	});
#      };
  };
}
