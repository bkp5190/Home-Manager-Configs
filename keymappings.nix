{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # Keymaps
    keymaps =
    [
      # oil mapping for file tree
      {
        action = ":Oil<CR>";
        key = "<leader>o";
        options = {
          silent = true;
          noremap = true;
          desc = "Oil Mapping";
        };
      }
      # Go to definition
      {
        action = ":lua vim.lsp.buf.definition()<CR>";
        key = "<leader>gd";
        options = {
          silent = true;
          noremap = true;
          desc = "Go to definition";
        };
      }
      # Go to references
      {
        action = ":lua vim.lsp.buf.references()<CR>";
        key = "<leader>gr";
        options = {
          silent = true;
          noremap = true;
          desc = "Go to references";
        };
      }
      # git blame open URL
      {
        action = ":GitBlameOpenCommitURL<CR>";
        key = "<leader>gb";
        options = {
          silent = true;
          noremap = true;
          desc = "Open git blame URL";
        };
      }
      # lazy git dashboard
      {
        action = ":LazyGit<CR>";
        key = "<leader>lg";
        options = {
          silent = true;
          noremap = true;
          desc = "Open lazygit";
        };
      }
      # markdown preview mapping
      {
        action = ":MarkdownPreview<CR>";
        key = "<leader>pm";
        options = {
          silent = true;
          noremap = true;
          desc = "Open markdown preview in browser";
        };
      }
      # toggle term floating in neovim
      {
        action = ":ToggleTerm direction=float<CR>";
        key = "<leader>f";
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle term floating window";
        };
      }
      # toggle term at the bottom on buffer
      {
        action = ":ToggleTerm<CR>";
        key = "<leader>b";
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle term bottom window";
        };
      }
      # Telescope search (live grep)
      {
        action = ":Telescope live_grep<CR>";
        key = "<leader>sg";
        options = {
          silent = true;
          noremap = true;
          desc = "Search grep";
        };
      }
      # Telescope search files
      {
        action = ":Telescope find_files<CR>";
        key = "<leader>sf";
        options = {
          silent = true;
          noremap = true;
          desc = "Search files";
        };
      }
      # Telescope search commands
      {
        action = ":Telescope commands<CR>";
        key = "<leader>sc";
        options = {
          silent = true;
          noremap = true;
          desc = "Search commands";
        };
      }
      # Telescope diagnostics
      {
        action = ":Telescope diagnostics<CR>";
        key = "<leader>d";
        options = {
          silent = true;
          noremap = true;
          desc = "Diagnostics";
        };
      }
      # Telescope quickfixlist
      {
        action = ":Telescope quickfix<CR>";
        key = "<leader>ql";
        options = {
          silent = true;
          noremap = true;
          desc = "Quickfix list";
        };
      }
      # Telescope undo tree
      {
        action = ":Telescope undo<CR>";
        key = "<leader>u";
        options = {
          silent = true;
          noremap = true;
          desc = "Undo tree";
        };
      }
      # Diffview open comparing in git
      {
        action = ":DiffviewOpen<CR>";
        key = "<leader>do";
        options = {
          silent = true;
          noremap = true;
          desc = "Diffview open";
        };
      }
      # Diffview close comparing in git
      {
        action = ":DiffviewClose<CR>";
        key = "<leader>dp";
        options = {
          silent = true;
          noremap = true;
          desc = "Diffview close";
        };
      }
      # Mapping q for recording macros
      {
        action = "q";
        key = "q";
        options = {
          silent = true;
          noremap = true;
        };
      }

      # Mapping Ctrl+V for block visual mode
      {
        action = "<C-v>";
        key = "<C-v>";
        options = {
          silent = true;
          noremap = true;
        };
      }

      # Buffers
      {
        action = ":BufferNext<CR>";
        key = "<Tab>";
        options = {
          silent = true;
          noremap = true;
          desc = "Next buffer";
        };
      }

      {
        action = ":BufferPrevious<CR>";
        key = "<S-Tab>";
        options = {
          silent = true;
          noremap = true;
          desc = "Prev buffer";
        };
      }
    ];
  };
}
