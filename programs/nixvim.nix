{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [];

  programs.nixvim = {
    enable = true;
    colorschemes.tokyonight.enable = true;

    clipboard.providers.wl-copy.enable = true;

    globals.mapleader = " ";

    viAlias = true;
    vimAlias = true;

    # General keymaps for nixvim
    keymaps = [
      {
        action = "<cmd>Ex<CR>";
        key = "<leader>e";
      }
      {
        mode = "n";
        action = "<cmd>w<CR>";
        key = "<C-s>";
      }
      {
        mode = "n";
        action = "<cmd>noh<CR>";
        key = "<esc>";
        options.silent = true;
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
        keymaps = {
          "<leader>sr" = {
            action = "oldfiles";
            desc = "[s]earch [r]ecent";
          };

          "<leader>sk" = {
            action = "keymaps";
            desc = "[s]earch [k]eys";
          };

          "<leader>sg" = {
            action = "live_grep";
            desc = "[s]earch [g]rep";
          };
        };
      };

      harppon = {
        enable = true;
        keymaps.addFile = "<leader>a";
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
        keymaps = {
          lspBuf = {
            "<leader>K" = "hover";
            "<leader>gD" = "references";
            "<leader>gd" = "definition";
            "<leader>gi" = "implementation";
            "<leader>gt" = "type_definition";
          };
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
          {
            name = "copilot";
            groupIndex = 1;
          }
          {
            name = "nvim_lsp";
            groupIndex = 1;
          }
          {name = "luasnip";}
          {name = "path";}
          {name = "buffer";}
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<Tab>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_next_item()";
          };
          "<S-Tab>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_prev_item()";
          };
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
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
