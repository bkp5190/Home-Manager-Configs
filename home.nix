{
  pkgs,
  ...
}:
let
in
{
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
    FZF_CTRL_T_OPTS = "--preview 'bat -n --color=always --line-range :500 {}'";
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
    tflint
    ffmpeg
    pylint
    go
    gopls
    golangci-lint
    # CLI tools
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
    gocyclo
    go-critic
    gofumpt
    golangci-lint-langserver
    air
    protolint
    podman
    podman-compose
    imagemagick
    tree-sitter
    fzf
    nodejs
    python312Packages.jupytext
    python312Packages.jupyter-client
    python312Packages.pynvim
    python312Packages.debugpy
    quarto
    graphviz
    uv
    p7zip
    neovim
    lua5_1
    uv
    gradle
  ];

  programs = {

    java = {
      enable = true;
      package = pkgs.openjdk17;
    };
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
        plugins = [
          "web-search"
          "copyfile"
          "copybuffer"
          "fzf"
        ];
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
      initContent = ''
        ;
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

    # tmux = {
    #   enable = true;
    #   shell = "${pkgs.writeShellScriptBin "zsh-login" ''
    #   exec ${pkgs.zsh}/bin/zsh -l
    #   ''}/bin/zsh-login";
    #   terminal = "tmux-256color";
    #   historyLimit = 100000;
    #   plugins = with pkgs;
    #     [
    #       tmux-nvim
    #       tmuxPlugins.tmux-thumbs
    #       tmuxPlugins.sensible
    #       # must be before continuum edits right status bar
    #       {
    #         plugin = tmuxPlugins.catppuccin;
    #         extraConfig = '' 
    #           set -g @catppuccin_flavour 'frappe'
    #           set -g @catppuccin_window_tabs_enabled on
    #           set -g @catppuccin_date_time "%H:%M"
    #         '';
    #       }
    #       {
    #         plugin = tmuxPlugins.resurrect;
    #         extraConfig = ''
    #           set -g @resurrect-strategy-vim 'session'
    #           set -g @resurrect-strategy-nvim 'session'
    #           set -g @resurrect-capture-pane-contents 'on'
    #         '';
    #       }
    #       {
    #         plugin = tmuxPlugins.continuum;
    #         extraConfig = ''
    #           set -g @continuum-restore 'on'
    #           set -g @continuum-boot 'on'
    #           set -g @continuum-save-interval '10'
    #         '';
    #       }
    #       tmuxPlugins.better-mouse-mode
    #       tmuxPlugins.yank
    #     ];
    #   extraConfig = ''
    #     set -g default-terminal "tmux-256color"
    #     set -ag terminal-overrides ",xterm-256color:RGB"
    #     set-option -g prefix M-space
    #     unbind C-b
    #     bind M-space send-prefix
    #
    #     set -g mouse on
    #     set-option -g set-clipboard on
    #
    #     setw -g mode-keys vi
    #
    #     bind -T copy-mode-vi v send -X begin-selection
    #     bind -T copy-mode-vi y send -X copy-selection-and-cancel
    #     bind -T copy-mode-vi C-v send -X rectangle-toggle
    #     bind Escape copy-mode
    #
    #     unbind '"'
    #     unbind %
    #     bind | split-window -h -c "#{pane_current_path}"
    #     bind - split-window -v -c "#{pane_current_path}"
    #
    #     bind -n M-h select-pane -L
    #     bind -n M-j select-pane -D
    #     bind -n M-k select-pane -U
    #     bind -n M-l select-pane -R
    #
    #     bind -n M-Left  previous-window
    #     bind -n M-Right next-window
    #
    #     bind -n M-h resize-pane -L 5
    #     bind -n M-l resize-pane -R 5
    #     bind -n M-j resize-pane -D 2
    #     bind -n M-k resize-pane -U 2
    #     bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
    #
    #     unbind p
    #     bind p paste-buffer
    #
    #     set-option -g status-position top
    #
    #     bind-key -T prefix C-l switch -t notes
    #     bind-key -T prefix C-d switch -t dotfiles
    #     bind-key -T prefix C-g split-window "$SHELL --login -i -c 'navi --print | head -c -1 | tmux load-buffer -b tmp - ; tmux paste-buffer -p -t {last} -b tmp -d'"
    #
    #     set -g @yank_selection 'clipboard'
    #   '';
    #   };
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
