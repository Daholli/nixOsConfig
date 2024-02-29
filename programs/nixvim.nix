{config, pkgs, inputs, ... }:

{
  imports = [];

  programs.nixvim = {
    enable = true;
    colorschemes.tokyonight.enable = true;

    globals.mapleader = " ";

    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>tg";
      }
      {
        action = "<cmd>Ex<CR>";
        key = "<leader>e";
      }
    ];

    options = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };

    plugins = {
      telescope = {
        enable = true;
      };

      treesitter = {
        enable = true;
      };

      luasnip.enable = true;

      lualine.enable = true;

      lsp = {
        enable = true;

        servers = {
          nixd.enable = true;
        };
      };

      lsp-format = {
        enable = true;
        setup = {
          nix = {
          };
        };
      };

      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "path";}
          {name = "buffer";}
        ];
      };

      nvim-autopairs.enable = true;

      rustaceanvim.enable = true;

      rainbow-delimiters.enable = true;
      nvim-colorizer.enable = true;

      undotree.enable = true;

      which-key.enable = true;

      trouble.enable = true;

      markdown-preview.enable = true;

      copilot-lua = {
        enable = true;
        panel.enabled = false;
        suggestion.enabled = false;
      };
      copilot-cmp.enable = true;
    };
  };

}
