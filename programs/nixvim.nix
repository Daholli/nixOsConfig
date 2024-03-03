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
        options.desc = "Open Explorer";
      }
      {
        mode = "n";
        action = "<cmd>w<CR>";
        key = "<C-s>";
        options.desc = "Save";
      }
      {
        mode = "n";
        action = "<cmd>noh<CR>";
        key = "<esc>";
        options.silent = true;
      }
      {
        mode = "n";
        action = "<cmd>Git add .<CR>";
        key = "<leader>gaa";
        options.desc = "Stage all changes";
      }
      {
        mode = "n";
        action = "<cmd>Git commit<CR>";
        key = "<leader>gc";
        options.desc = "Git Commit";
      }
      {
        mode = "n";
        action = "<cmd>UndotreeToggle<CR>";
        key = "<leader>ut";
        options.desc = "Toggle Undotree";
      }
      {
        mode = "n";
        action = "<cmd>UndotreeToggle<CR>";
        key = "<leader>uf";
        options.desc = "Focus Undotree";
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

      harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader>a";
          toggleQuickMenu = "<leader>ha";
          navFile = {
            "1" = "<C-1>";
            "2" = "<C-2>";
            "3" = "<C-3>";
            "4" = "<C-4>";
          };
        };
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
            "<leader>ch" = "hover";
            "<leader>cD" = "references";
            "<leader>cd" = "definition";
            "<leader>ci" = "implementation";
            "<leader>ct" = "type_definition";
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

      rustaceanvim.enable = true;

      fugitive.enable = true;

      rainbow-delimiters.enable = true;
      nvim-colorizer.enable = true;

      undotree.enable = true;

      which-key = {
        enable = true;
        registrations = {
          "<leader>ch" = "Code hover";
          "<leader>cD" = "Code references";
          "<leader>cd" = "Code definitions";
          "<leader>ci" = "Implementations";
          "<leader>ct" = "Type definition";
        };
      };

      trouble.enable = true;

      markdown-preview.enable = true;

      copilot-lua = {
        enable = true;
        panel.enabled = false;
        suggestion.enabled = false;
      };

      copilot-cmp = {
        enable = true;
        fixPairs = true;
      };
    };
  };
}
