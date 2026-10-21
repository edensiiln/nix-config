{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.edenNiri = {
    pkgs,
    #pkgs-stable,
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
    #pkgs-stable,
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

        input = {
          focus-follows-mouse = _: { };

          keyboard.xkb = {
	          layout = "us,jp,cn";
      	    options = "grp:win_space_toggle";
      	  };
        };

        layout = {
          
          gaps = 5;

          preset-column-widths = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
            {proportion = 1.0;}
          ];

            #tab-indicator.length = "total-propoption";
            tab-indicator.position = "right";

        };

        binds = {

          # General
          "Mod+Shift+Slash".show-hotkey-overlay = _: { };
          "Mod+Grave".toggle-overview = _: { };
          "Mod+D".spawn-sh = "${lib.getExe self'.packages.edenNoctalia} ipc call launcher toggle";
          "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;


          # Window/Column Misc
          "Mod+Q".close-window = _: { };

          "Mod+Tab".toggle-column-tabbed-display = _: { };

          "Mod+Ctrl+V".toggle-window-floating = _: { };
          "Mod+MouseMiddle".toggle-window-floating = _: { };


          # Window/Column Resizing
          "Mod+F".maximize-column = _: { };
          "Mod+Shift+F".fullscreen-window = _: { };
          "Mod+Ctrl+F".expand-column-to-available-width = _: { };

          "Mod+R".switch-preset-column-width = _: { };
          "Mod+Shift+R".switch-preset-column-width-back = _: { };


          # Window/Column Movement
          "Mod+BracketLeft".consume-or-expel-window-left = _: { };
          "Mod+BracketRight".consume-or-expel-window-right = _: { };

          "Mod+Shift+Left".move-column-left = _: { };
          "Mod+Shift+Right".move-column-right = _: { };
          "Mod+Shift+Up".move-column-to-workspace-up = _: { };
          "Mod+Shift+Down".move-column-to-workspace-down = _: { };
          
          "Mod+Ctrl+Left".consume-or-expel-window-left = _: { };
          "Mod+Ctrl+Right".consume-or-expel-window-right = _: { };
          "Mod+Ctrl+Up".move-window-up-or-to-workspace-up = _: { };
          "Mod+Ctrl+Down".move-window-down-or-to-workspace-down = _: { };
          

          "Mod+C".center-column = _: { };


          # Focusing
          "Mod+Left".focus-column-left = _: { };
          "Mod+Right".focus-column-right = _: { };
          "Mod+Up".focus-window-or-workspace-up = _: { };
          "Mod+Down".focus-window-or-workspace-down = _: { };

            #"Mod+Shift+Left".focus-monitor-left = _: { };
            #"Mod+Shift+Right".focus-monitor-right = _: { };
            #"Mod+Shift+Up".focus-monitor-up = _: { };
            #"Mod+Shift+Down".focus-monitor-down = _: { };

          "Mod+WheelScrollUp".focus-column-left = _: { };
          "Mod+WheelScrollDown".focus-column-right = _: { };
          "Mod+Ctrl+WheelScrollDown".focus-workspace-down = _: { };
          "Mod+Ctrl+WheelScrollUp".focus-workspace-up = _: { };
          "Mod+WheelScrollLeft".focus-monitor-left = _: { };
          "Mod+WheelScrollRight".focus-monitor-right = _: { };


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
