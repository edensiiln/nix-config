{config, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      #shell = "nu";
      colors = with config.colorscheme.palette; {
        primary = {
          foreground = "0x${base06}";
          background = "0x${base00}";
        };
        normal = {
          black = "0x${base00}";
          red = "0x${base08}";
          green = "0x${base0B}";
          yellow = "0x${base0A}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          cyan = "0x${base0C}";
          white = "0x${base06}";
        };
        bright = {
          black = "0x${base00}";
          red = "0x${base08}";
          green = "0x${base0B}";
          yellow = "0x${base09}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          cyan = "0x${base0C}";
          white = "0x${base06}";
        };
      };
    };
  };
}
