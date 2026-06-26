{
  lib,
  config,
  ...
}: {
  options = {
    yaziModule.enable = lib.mkEnableOption "enable yazi";
  };

  config = lib.mkIf config.yaziModule.enable {
    programs.yazi.enable = true;
    programs.yazi.enableZshIntegration = true;
    programs.yazi.shellWrapperName = "y";
    programs.yazi.settings = {
      mgr.ratio = [
        1
        3
        4
      ];

      sort-by = "natural";
      sort-sensitive = true;
      sort-reverse = false;
      sort-dir-first = true;
      sort-translit = true;
      linemode = "none";
      show-hidden = true;
      show-symlink = true;
      scrolloff = 5;

      preview = {
        image-filter = "lanczos3";
        image-quality = 90;
        tab-size = 1;
        max-width = 600;
        max-height = 900;
        cache-dir = "";
        ueberzug-scale = 1;
        ueberzug-offset = [
          0
          0
          0
          0
        ];
      };

      tasks = {
        image-bound = [0 0];
        micro-workers = 5;
        macro-workers = 10;
        bizarre-retry = 5;
      };
    };

    programs.yazi.theme.filetype.rules = with config.colorscheme.palette; [
      {
        mime = "image/*";
        fg = "#${base0B}";
      }
      {
        mime = "video/*";
        fg = "#${base03}";
      }
      {
        mime = "audio/*";
        fg = "#${base08}";
      }
    ];
  };
}
