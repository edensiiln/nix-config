{
  config,
  inputs,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        theme = {
          enable = true;

          name = "base16";
          base16-colors = with config.colorscheme.palette; {
            base00 = "${base00}";
            base01 = "${base01}";
            base02 = "${base02}";
            base03 = "${base03}";
            base04 = "${base04}";
            base05 = "${base05}";
            base06 = "${base06}";
            base07 = "${base07}";
            base08 = "${base08}";
            base09 = "${base09}";
            base0A = "${base0A}";
            base0B = "${base0B}";
            base0C = "${base0C}";
            base0D = "${base0D}";
            base0E = "${base0E}";
            base0F = "${base0F}";
          };
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          nix.lsp.server = "nixd";

          rust.enable = true;
        };

        options = {
          tabstop = 2;
          shiftwidth = 2;
        };

        ui.colorizer = {
          enable = true;
          setupOpts.filetypes = {
            "*" = {};
          };
        };
      };
    };
  };
}
