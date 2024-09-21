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
    ./noice.nix
    ./oil.nix
    ./tagbar.nix
    ./telescope.nix
    ./toggleterm.nix
    ./tree-sitter.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    colorschemes = {
      gruvbox = {
        enable = true;
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
      none-ls.enable = true;

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
