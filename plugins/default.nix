{
  imports = [
    ./barbar.nix
    ./codesnap.nix
    ./comment.nix
    ./dap.nix
    ./gitblame.nix
    ./harpoon.nix
    ./indent-o-matic.nix
    ./jupyter.nix
    ./lazygit.nix
    ./lint.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./nix.nix
    ./noice.nix
    ./oil.nix
    ./smear-cursor.nix
    ./telescope.nix
    ./tree-sitter.nix
    ./trouble.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    colorschemes = {
      onedark = {
        enable = true;
        settings = {
          style = "cool";
        };
      };
      nightfox = {
        enable = false;
      };
      monokai-pro = {
        enable = false;
      };
      gruvbox = {
        enable = false;
        settings = {
          transparent_mode = false;
        };
      };

      catppuccin = {
        enable = false;
        settings = {
        flavour = "mocha";
        integrations = {
          cmp = true;
          gitsigns = true;
          nvimtree = true;
          treesitter = true;
          notify = false;
          };
        };
      };
      kanagawa = {
        enable = false;
        settings = {
          colors = {
            palette = {
              fujiWhite = "#FFFFFF";
              sumiInk0 = "#000000";
            };
            theme = {
              all = {
                ui = {
                  bg_gutter = "none";
                };
              };
              dragon = {
                syn = {
                  parameter = "yellow";
                };
              };
              wave = {
                ui = {
                  float = {
                    bg = "none";
                  };
                };
              };
            };
          };
          commentStyle = {
            italic = true;
          };
          compile = false;
          dimInactive = false;
          functionStyle = { };
          overrides = "function(colors) return {} end";
          terminalColors = true;
          theme = "wave";
          transparent = false;
          undercurl = true;
        };
      };
    };

    plugins = {
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      transparent.enable = true;

      web-devicons.enable = true;

      nvim-autopairs.enable = true;
      none-ls.enable = true;
      nvim-surround.enable = true;

      trim = {
        enable = true;
        settings = {
          highlight = false;
          ft_blocklist = [
            "checkhealth"
            "floaterm"
            "lspinfo"
            "TelescopePrompt"
          ];
        };
      };
    };
  };
}
