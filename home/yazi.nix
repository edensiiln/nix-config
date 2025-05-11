{
  lib,
  config,
  ...
}:
{
  #programs.yazi.enable = true;

  options = {
    yaziModule.enable = lib.mkEnableOption "enable yazi";
  };

  config = lib.mkIf config.yaziModule.enable {
    programs.yazi.enable = true;
    programs.yazi.settings = {
      manager.ratio = [
        1
        3
        4
      ];
    };
  };
}
