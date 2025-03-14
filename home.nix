{
  pkgs,
  ...
}: let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "main";
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
  home.stateVersion = "25.05";

  # Set up some basic settings for the home environment.
  home.username = "boneypatel";
  home.homeDirectory = "/Users/boneypatel";

  nixpkgs.config.allowUnfree = true;

  # Define the Home Manager environment variables.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    LANG = "en_US.UTF-8";
    FZF_CTRL_T_OPTS = "--preview 'bat -n --color=always --theme='Catppuccin Mocha' --line-range :500 {}'";
    FZF_ALT_C_OPTS = "--preview 'eza --tree --color=always {} | head -200'";
  };

  # Enable custom fonts
  fonts.fontconfig.enable = true;

  # Specify the desired packages to install in the user environment.
  home.packages = with pkgs; [
    git
    curl
    wget
    lazygit
    tmux
    # Telescope
    ripgrep
    # zsh-powerlevel10k
    # Allow copying to clipboard from tmux
    reattach-to-user-namespace
    # Nix curl
    nurl
    # Nix formatting
    nixpkgs-fmt
    nixpkgs-review
    # File directories
    tree
    xclip
    vale
    tflint
    pylint
    go
    gopls
    golangci-lint
    # CLI tools
    fzf
    thefuck
    bat
    eza
    delta
    tldr
    zoxide
    fd
    # Linting
    hadolint
    # Python linter
    ruff
    pyright
    # Passwords
    pass
    gnupg
    kitty-themes
    jetbrains-mono
    cascadia-code
    aerospace
    jankyborders
    gh
    # tmux replacement
    zellij
    mousecape
    # Golang templ
    delve
    gotests
    templ
    tailwindcss
    gocyclo
    go-critic
    gofumpt
    golangci-lint-langserver
    air
    protolint
    podman
    podman-compose
    imagemagick
    openscad
  ];

  programs = {
    # Enable Home Manager to manage your home directory.
    home-manager.enable = true;

    # direnv
    direnv.enable = true;

    # Enable and configure some basic programs.
    git = {
      enable = true;
      userName = "bpatel347";
      userEmail = "bpatel347@gatech.edu";

      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
        };
        "github.gatech.edu" = {
          hostname = "github.gatech.edu";
          user = "git";
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
        hms = "home-manager switch";
        lg = "lazygit";
        v = "nvim";
        c = "clear";
        cat = "bat --theme='Catppuccin Mocha'";
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

      plugins = [
        # Autocompletions
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.1";
            hash = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
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

    # Atuin
    atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        dialect = "us";
        style = "compact";
        inline_height = 15;
      };
    };

    # Neovim
    nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      luaLoader.enable = true;
    };

    # Starship command history
    starship = {
      enable = true;
    };

    # Kitty terminal
    kitty = {
      enable = false;
      font = {
        name = "Cascadia Mono NF";
        size = 14;
      };
      shellIntegration.enableZshIntegration = true;
      themeFile = "Monokai_Pro";
      settings = {
        background_opacity = 1.0;
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
      };
    };
  };
}
