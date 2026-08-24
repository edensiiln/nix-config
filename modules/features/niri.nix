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
    ... }: {
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

	#outputs."DP-1" = {
	  #position.x = 0;
	  #position.y = 0;
	  #transform.rotation = 90;
	#};
	outputs."DP-1".transform = "90";

        #outputs."DP-1".name = "monitor-A";
        #outputs."HDMI-A-1".name = "monitor-B";
        #outputs."DP-3".name = "monitor-C";

	#outputs."HDMI-A-1".position = ["${"x=1080"}" "${"y=840"}"];
	#outputs."HDMI-A-1" = { "position x=1080 y=840" };
	#outputs."HDMI-A-1".position.x = 1080;
	#outputs."HDMI-A-1".position.y = 840;
	#outputs."DP-3".position = { x = 3000; y = 840; };
	#outputs."DP-3".position.x = "3000";
	#outputs."DP-3".position.y = "840";

	

      };
    };
  };
}
