{ config, pkgs, ... }:

let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
  });
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];
  # Define the state version, which corresponds to the version of Home Manager
  # you are using. This should be updated whenever you update Home Manager.
  home.stateVersion = "24.05";

  # Enable Home Manager to manage your home directory.
  programs.home-manager.enable = true;

  # Set up some basic settings for the home environment.
  home.username = "boneypatel";
  home.homeDirectory = "/Users/boneypatel";

  # Define the Home Manager environment variables.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_US.UTF-8";
  };

  # Enable custom fonts
  fonts.fontconfig.enable = true;

  # Specify the desired packages to install in the user environment.
  home.packages = with pkgs; [
    vim
    git
    curl
    wget
    lazygit
    tmux
    ripgrep
    zsh-powerlevel10k
    # Allow copying to clipboard from tmux
    reattach-to-user-namespace
    direnv
    devbox
  ];

  # Enable and configure some basic programs.
  programs.git = {
    enable = true;
    userName = "bkp5190";
    userEmail = "boneypatel37@yahoo.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "bkp5190";
        identityFile = "~/.ssh/id_ed25519.pub";
      };
      "github.gatech.edu" = {
        hostname = "github.gatech.edu";
        user = "bpatel347";
        identityFile = "~/.ssh/id_rsa.pub";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";

    shellAliases = {
      lg = "lazygit";
      v = "nvim";
      c = "clear";
    };
    oh-my-zsh.enable = true;
    oh-my-zsh.extraConfig = builtins.readFile ./extraConfig.zsh;
    initExtraBeforeCompInit = ''
      # p10k instant prompt
      local P10K_INSTANT_PROMPT="${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';

    plugins = with pkgs; [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        file = ".p10k.zsh";
        name = "powerlevel10k-config";
        src = ./.p10k.zsh;
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "v2.2.1";
          sha256 = "0iqa9j09fwm6nj5rpip87x3hnvbbz9w9ajgm6wkrd5fls8fn8i5g";
        };
      }
    ];
    initExtra = '';
      [[ ! -f ~/.config/home-manager/.p10k.zsh ]] || source ~/.config/home-manager/.p10k.zsh
    '';
  };

  # Tmux configs
  programs.tmux = {
    enable = true;
    clock24 = true;
    tmuxinator.enable = true;

    extraConfig = builtins.readFile ./extraConfig.tmux;
  };

  # Nixvim configs
  programs.nixvim = {

    # Keymaps
    keymaps = 
    [
      # oil mapping for file tree 
      {
        action = ":Oil<CR>";
        key = "<leader>o";
        options = {
          silent = true;
        };
      }
      # git blame open URL
      {
        action = ":GitBlameOpenCommitURL<CR>";
        key = "<leader>gb";
        options = {
          silent = true;
        };
      }
      # lazy git dashboard
      {
        action = ":LazyGit<CR>";
        key = "<leader>lg";
        options = {
          silent = true;
        };
      }
      # markdown preview mapping
      {
        action = ":PreviewMarkdown<CR>";
        key = "<leader>pm";
        options = {
          silent = true;
        };
      }
      # toggle term floating in neovim
      {
        action = ":ToggleTerm direction=float<CR>";
        key = "<leader>f";
        options = {
          silent = true;
        };
      }
      # toggle term at the bottom on buffer
      {
        action = ":ToggleTerm<CR>";
        key = "<leader>b";
        options = {
          silent = true;
        };
      }
      # Telescope search (live grep)
      {
        action = ":Telescope live_grep<CR>";
        key = "<leader>sg";
        options = {
          silent = true;
        };
      }
      # Telescope search files
      {
        action = ":Telescope find_files<CR>";
        key = "<leader>sf";
        options = {
          silent = true;
        };
      }
      # Telescope search commands
      {
        action = ":Telescope commands<CR>";
        key = "<leader>sc";
        options = {
          silent = true;
        };
      }
      # Telescope diagnostics
      {
        action = ":Telescope diagnostics<CR>";
        key = "<leader>d";
        options = {
          silent = true;
        };
      }
      # Telescope quickfixlist
      {
        action = ":Telescope quickfix<CR>";
        key = "<leader>q";
        options = {
          silent = true;
        };
      }
      # Telescope undo tree
      {
        action = ":Telescope undo<CR>";
        key = "<leader>u";
        options = {
          silent = true;
        };
      }
      # Diffview open comparing in git
      {
        action = ":DiffviewOpen<CR>";
        key = "<leader>do";
        options = {
          silent = true;
        };
      }
      # Diffview close comparing in git
      {
        action = ":DiffviewClose<CR>";
        key = "<leader>dp";
        options = {
          silent = true;
        };
      }
      # # Harpoon add
      # {
      #   action = "function() harpoon:list():add() end";
      #   key = "<leader>ha";
      #   options = {
      #     silent = true;
      #   };
      # }
      # # Harpoon toggle
      # {
      #   action = "function() harpoon.ui:toggle_quick_menu(harpoon:list()) end";
      #   key = "<leader>ht";
      #   options = {
      #     silent = true;
      #   };
      # }
      #

    ];
  
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
    colorschemes.catppuccin.enable = true;
    clipboard.register = "unnamedplus";

    # Options
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 4;

    };
    # Neovim plugins
    plugins = {

      # Nix
      nix = {
        enable = true;
      };

      # Best git extension
      lazygit = {
        enable = true; 
      };

      # Git blame for git history
      gitblame = {
        enable = true;
      };

      # File explorer buffer
      oil = {
        enable = true; 
      };

      # Navigate from tmux <--> neovim
      tmux-navigator = {
        enable = true;
      };

      # Tracks keybindings
      which-key = {
        enable = true;
      };

      # Floating terminal
      toggleterm = {
        enable = true;
      };

      # Fuzzy finding and searching
      telescope = {
        enable = true;
        extensions = {
          file-browser.enable = true;
          undo.enable = true;

          # Undo tree extension
          undo.settings = {
            mappings = {
              i = {
                "<c-cr>" = "require('telescope-undo.actions').restore";
                "<cr>" = "require('telescope-undo.actions').yank_additions";
                "<s-cr>" = "require('telescope-undo.actions').yank_deletions";
              };
              n = {
                Y = "require('telescope-undo.actions').yank_deletions";
                u = "require('telescope-undo.actions').restore";
                y = "require('telescope-undo.actions').yank_additions";
              };
            };
          };
        };
      };

      # Render markdown files while editing
      markdown-preview = {
        enable = true;
      };

      # Tabs for buffers
      barbar = {
        enable = true;
        keymaps = {
          previous.key = "<S-Tab>";
          next.key = "<Tab>";
          close.key = "<leader>x";
        };
      };

      # Rainbow delimiters
      rainbow-delimiters = {
        enable = true;
      };

      # Treesitter for rainbow delimiters
      treesitter = {
        enable = true;
      };

      # Diff view to compare in git
      diffview = {
        enable = true;
      };

      # Focus on certain portions of code
      twilight = {
        enable = true;
      };

      # Indenting help
      indent-o-matic = {
        enable = true;
      };

      # # Quick swap files
      # harpoon = {
      #   enable = true;
      #   enableTelescope = true;
      # };

      # Language server protocols
      lsp = {
        enable = true;
	servers = {

	  # Nix LSP
	  nil-ls.enable = true;

	  # Python
	  pyright.enable = true;

	  # Markdown
	  marksman.enable = true;

	  # Bash
	  bashls.enable = true;

	};
      };
    };

    extraPlugins = with pkgs.vimPlugins;
      [
        nvim-web-devicons
      ];
  };

}

