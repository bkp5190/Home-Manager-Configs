{
  imports = [
    ./barbar.nix
    ./comment.nix
    ./gitblame.nix
    ./harpoon.nix
    ./lazygit.nix
    ./lint.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./noice.nix
    ./oil.nix
    ./tagbar.nix
    ./telescope.nix
    ./tmux-navigator.nix
    ./toggleterm.nix
    ./tree-sitter.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    colorschemes = {
      gruvbox = {
        enable = false;
        settings = {
          transparent_mode = true;
        };
      };
      kanagawa = {
        enable = true;
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
