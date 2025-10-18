{
  lib,
  config,
  ...
}:
{

  options = {
    yaziModule.enable = lib.mkEnableOption "enable yazi";
  };

  config = lib.mkIf config.yaziModule.enable {
    programs.yazi.enable = true;
    programs.yazi.enableZshIntegration = true;
    programs.yazi.settings = {

      mgr.ratio = [
        1
        3
        4
      ];

      sort_by = "natural";
      sort_sensitive = true;
      sort_reverse = false;
      sort_dir_first = true;
      sort_translit = true;
      linemode = "none";
      show_hidden = true;
      show_symlink = true;
      scrolloff = 5;

      preview = {
      image_filter = "lanczos3";
      image_quality = 90;
      tab_size = 1;
      max_width = 600;
      max_height = 900;
      cache_dir = "";
      ueberzug_scale = 1;
      ueberzug_offset = [
        0
        0
        0
        0
      ];
    };

      tasks = {
	image_bound = [0 0];
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
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
