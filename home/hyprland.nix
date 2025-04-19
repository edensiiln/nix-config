{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,auto";
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
      gaps_out = "10";
      border_size = "2";
      "col.active_border" = "rgba(33ccffee) rgba(cf3a3aee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      layout = "dwindle";

      allow_tearing = "false";
    };

    decoration = {
      rounding = "5";

      blur = {
        enabled = true;
        size = "3";
        passes = "1";
      };

      #drop_shadow = "yes";
      #shadow_range = "4";
      #shadow_render_power = "3";
      #"col.shadow" = "rgba(1a1a1aee)";
    };

    animations = {
      enabled = "yes";
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
    };

    # LAYOUTS

    dwindle = {
      pseudotile = false;
      preserve_split = true;
    };

    #master = {
    #  new_is_master = true;
    #};

    gestures = {
      workspace_swipe = "off";
    };

    misc = {
      force_default_wallpaper = "0";
    };

    # BINDS

    "$mod" = "SUPER";
    "$prtsc" = "code:107";

    bind = [
      # exec binds
      "$mod, RETURN, exec, alacritty"
      "$mod, D, exec, wofi --show drun"
      "$mod, F, exec, thunar"
      "$mod, B, exec, floorp"
      "$mod, O, exec, obsidian"
      "$mod, SPACE, exec, cliphist list | wofi --show dmenu -H 600 -W 900   | cliphist decode | wl-copy"

      # PRINTSCREEN
      # selection to clipboard
      ", $prtsc, exec, grim -g \"$(slurp)\" - | wl-copy"
      # selection to image editor
      "CTRL, $prtsc, exec, grim -g \"$(slurp)\" - | swappy -f -"

      # active monitor to clipboard
      "SHIFT, $prtsc, exec, grim -o \"$(hyprctl monitors | awk '/Monitor/{mon=$2} /focused: yes/{print mon}')\" - | wl-copy"
      # active monitor to image editor
      "SHIFT CTRL, $prtsc, exec, grim -o \"$(hyprctl monitors | awk '/Monitor/{mon=$2} /focused: yes/{print mon}')\" - | swappy -f -"

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
      "$mod, 0, workspace, 10"

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
      "$mod SHIFT, 0, movetoworkspace, 10"

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

    windowrule = [
      #"float, class:^(org.pulseaudio.pavucontrol)$"
      "float, class:org.pulseaudio.pavucontrol"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = kanshi
    exec-once = hyprpaper --config /home/eden/.dotfiles/.config/hyprpaper.conf
    exec-once = nm-applet --indicator
    exec-once = dunst
    exec-once = wl-clipboard-history -t
    exec-once = wl-paste --watch cliphist store
    exec-once = rm "$HOME/.cache/cliphist/db"
    exec-once = discord

    animations {
      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }
  '';
}
