{
  imports = [
    ./barbar.nix
    ./comment.nix
    ./harpoon.nix
    ./lazygit.nix
    ./lint.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./oil.nix
    ./tagbar.nix
    ./telescope.nix
    ./toggleterm.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "macchiato";
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

      nvim-autopairs.enable = true;

      trim = {
        enable = true;
        settings = {
          highlight = true;
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
