{
  config,
  pkgs,
  ...
}: let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
  });
in {
  imports = [
    nixvim.homeManagerModules.nixvim
    ./autocommands.nix
    ./completion.nix
    ./keymappings.nix
    ./options.nix
    ./plugins
    ./todo.nix
  ];
  # Define the state version, which corresponds to the version of Home Manager
  # you are using. This should be updated whenever you update Home Manager.
  home.stateVersion = "24.05";

  # Set up some basic settings for the home environment.
  home.username = "boneypatel";
  home.homeDirectory = "/Users/boneypatel";

  # Define the Home Manager environment variables.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_US.UTF-8";
    FZF_CTRL_T_OPTS = "--preview 'bat -n --color=always --line-range :500 {}'";
    FZF_ALT_C_OPTS = "--preview 'eza --tree --color=always {} | head -200'";
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
    # Nix curl
    nurl
    # File directories
    tree
    # Dotnet for Unity and C#
    dotnet-sdk_8
    vale
    tflint
    # CLI tools
    fzf
    thefuck
    bat
    eza
    delta
    tldr
    zoxide
  ];

  programs = {
    # Enable Home Manager to manage your home directory.
    home-manager.enable = true;

    # Enable and configure some basic programs.
    git = {
      enable = true;
      userName = "bkp5190";
      userEmail = "boneypatel37@yahoo.com";

      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    ssh = {
      enable = false;
      forwardAgent = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "bkp5190";
          identityFile = "~/.ssh/id_ed25519";
        };
        "github.gatech.edu" = {
          hostname = "github.gatech.edu";
          user = "bpatel347";
          identityFile = "~/.ssh/ga_id_ed25519";
        };
      };
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      dotDir = ".config/zsh";

      shellAliases = {
        lg = "lazygit";
        v = "nvim";
        c = "clear";
        cat = "bat";
        fk = "fuck";
        ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
        cd = "z";
        s = "web_search duckduckgo";
      };
      oh-my-zsh = {
        enable = true;
        extraConfig = builtins.readFile ./extraConfig.zsh;
        # Additional oh-my-zsh plugins
        plugins = ["web-search" "copyfile" "copybuffer" "fzf" "thefuck" ];
      };

      initExtraBeforeCompInit = ''
        # p10k instant prompt
        local P10K_INSTANT_PROMPT="${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
        [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      '';

      plugins = with pkgs; [
        # Powerlevel10k theme
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
        # Autocompletions
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.4.0";
            sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
          };
        }
        # Completion scroll
        {
          name = "zsh-completions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "0.35.0";
            hash = "sha256-GFHlZjIHUWwyeVoCpszgn4AmLPSSE8UVNfRmisnhkpg=";
          };
        }
        # Highlight commands in terminal
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.8.0";
            hash = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
          };
        }
      ];
      initExtra = ''        ;
                [[ ! -f ~/.config/home-manager/.p10k.zsh ]] || source ~/.config/home-manager/.p10k.zsh
      '';
    };

    # Tmux configs
    tmux = {
      enable = true;
      clock24 = true;
      tmuxinator.enable = true;

      extraConfig = builtins.readFile ./extraConfig.tmux;
    };

    # Nixvim
    nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      luaLoader.enable = true;
    };
  };
}
