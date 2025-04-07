{ config, pkgs, lib, inputs, ... }:
{
  imports = [ inputs.nvf.nixosModules.default ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "base16";
          base16-colors = {
            base00 = "0x${base00}";
	    base01 = "0x${base01}";
	    base02 = "0x${base02}";
	    base03 = "0x${base03}";
	    base04 = "0x${base04}";
	    base05 = "0x${base05}";
	    base06 = "0x${base06}";
	    base07 = "0x${base07}";
	    base08 = "0x${base08}";
	    base09 = "0x${base09}";
	    base0A = "0x${base0A}";
	    base0B = "0x${base0B}";
	    base0C = "0x${base0C}";
	    base0D = "0x${base0D}";
            base0E = "0x${base0E}";
	    base0F = "0x${base0F}";
          };
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
        };
      };
    };
  };
  
}
