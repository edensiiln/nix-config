{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {

    monitor = ",preferred,auto,auto";

    exec-once = "waybar & discord";
    #source = ./hyprland-colors.conf

    env = "XCURSOR_SIZE,24";

    input = {
      kb_layout = "us";
      kb_variant = "";
      kb_model = "";
      kb_options = "";
      kb_rules = "";

      follow_mouse = "1";

      touchpad.natural_scroll = "no";

      sensitivity = "0";
    };

    general = {
      gaps_in = "5";
      gaps_out = "20";
      border_size = "2";
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      layout = "dwindle";

      allow_tearing = "false";
    };

    decoration = {
      rounding = "10";

      blur = {
        enabled = true;
	size = "3";
	passes = "1";
      };

      drop_shadow = "yes";
      shadow_range = "4";
      shadow_render_power = "3";
      "col.shadow" = "rgba(1a1a1aee)";
    };

    animations = {
      enabled = "yes";

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      #animation = "windows, 1, 7, myBezier";
      #animation = "windowsOut, 1, 7, default, popin 80%";
      #animation = "border, 1, 10, default";
      #animation = "borderangle, 1, 8, default";
      #animation = "fade, 1, 7, default";
      #animation = "workspaces, 1, 6, default";
    };
    extraConfig = ''
      animations {
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }
    '';

    # LAYOUTS
    
    dwindle = {
      pseudotile = false;
      preserve_split = true;
    };
    
    master = {
      new_is_master = true;
    };

    gestures = {
      workspace_swipe = "off";
    };

    misc = {
      force_default_wallpaper = "-1";
    };

    # BINDS

    "$mod" = "SUPER";

    bind = [
      # exec binds
      "$mod, RETURN, exec, alacritty"
      "$mod, D, exec, wofi --show drun"
      "$mod, F, exec, thunar"
      
      # window management
      "$mod SHIFT, Q, killactive"
      "$mod, M, exit"
      "$mod, V, togglefloating"

      # dwindle
      "$mod, P, pseudo"
      "$mod, J, togglesplit"

      # switch workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 10, workspace, 10"

      # move active window to a workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 10, movetoworkspace, 10"

      # scratchpad
      #"$mod, S, togglespecialworkspace, magic"
      #"$mod SHIFT, S movetoworkspace, special:magic"

      # scroll through existing workspaces
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ];

    # move/resize windows
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
