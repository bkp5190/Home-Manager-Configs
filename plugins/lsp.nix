{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          gopls.enable = true;
          golangci-lint-ls.enable = true;
          lua-ls.enable = true;
          nil-ls.enable = true;
          pyright.enable = true;
          tflint.enable = true;
          terraformls.enable = true;
          omnisharp.enable = true;
        };
      };
    };
  };
}
