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
            re = "rename";
          };
        };

        servers = {
          gopls = {
            enable = true;
            filetypes = [ "go" "gomod" "gowork" "gotmpl" ];
            settings =
              {
                usePlaceholders = true;
                completeUnimported = true;
                completeFunctionCalls = true;
                staticcheck = true;
                matcher = "fuzzy";
                analyses = {
                  unusedparams = true;
                  shadow = true;
                };
              };
          };
          golangci_lint_ls.enable = true;
          lua_ls.enable = true;
          nil_ls.enable = true;
          pyright.enable = true;
          pylsp.enable = true;
          tflint.enable = true;
        };
      };
      lsp-format = {
        enable = true;
      };
    };
  };
}
