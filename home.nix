{ pkgs, ... }:

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

  # Define user-specific aliases.
  home.shellAliases = {
    lg = "lazygit";
    v = "nvim";
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
  ];

  # Enable and configure some basic programs.
  programs.git = {
    enable = true;
    userName = " bkp5190";
    userEmail = "boneypatel37@yahoo.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    matchBlocks = {
      "github.com" = {
        user = "bkp5190";
        identityFile = "~/.ssh/id_ed25519.pub";
      };
      "github.gatech.edu" = {
        user = "bpatel347";
        identityFile = "~/.ssh/id_ed25519.pub";
      };
    };
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      theme = "powerlevel10k/powerlevel10k";
      enable = true;
      plugins = [ "git" "z" "sudo" "powerlevel10k"];
    };
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

      # Multiple cursors
      multicursors = {
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

