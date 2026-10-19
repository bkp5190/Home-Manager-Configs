{
  pkgs,
  config,
  ...
}:
let
  ohMyTmux = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "58a3dcc0d718ec0fa1c0d5a2fddd640a1ad7a5b7";
    hash = "sha256-YDzbZVFhrAMBhOI8HVDxR3rEPkrEwG57IUbnZicmfn4=";
  };
in
{
  home.file.".ssh/allowed_signers".text =
    "* ${builtins.readFile /Users/boneypatel/.ssh/id_ed25519.pub}";

  # Compatibility baseline for stateful settings, not the installed version.
  # Keep this unchanged during upgrades unless migrating state deliberately.
  home.stateVersion = "26.05";

  # Set up some basic settings for the home environment.
  home.username = "boneypatel";
  home.homeDirectory = "/Users/boneypatel";

  nixpkgs.config.allowUnfree = true;

  # Define the Home Manager environment variables.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "ghostty";
    LANG = "en_US.UTF-8";
    JAVA_HOME = "${pkgs.jdk17}";
    ANDROID_HOME = "${config.home.homeDirectory}/Library/Android/sdk";
    ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Library/Android/sdk";
    FZF_CTRL_T_OPTS = "--preview 'bat -n --color=always --line-range :500 {}'";
    FZF_ALT_C_OPTS = "--preview 'eza --tree --color=always {} | head -200'";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/Library/Android/sdk/platform-tools"
    "${config.home.homeDirectory}/Library/Android/sdk/emulator"
    "${config.home.homeDirectory}/Library/Android/sdk/cmdline-tools/latest/bin"
  ];

  # Enable custom fonts
  fonts.fontconfig.enable = true;

  # Specify the desired packages to install in the user environment.
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "scrollback";
      runtimeInputs = [ neovim tmux ];
      text = ''
        if [ -n "''${TMUX:-}" ]; then
          capture=$(mktemp -t nvim-scrollback)
          trap 'rm -f "$capture"' EXIT
          tmux capture-pane -p -J -S - -t "''${1:-$TMUX_PANE}" > "$capture"
        else
          capture=$(/usr/bin/pbpaste)
          if [ ! -f "$capture" ] || [ ! -r "$capture" ]; then
            echo "Press Cmd-Shift-J in Ghostty first to copy the scrollback file path." >&2
            exit 1
          fi
        fi
        nvim -R -n -- "$capture"
      '';
    })
    curl
    wget
    lazygit
    ripgrep
    reattach-to-user-namespace
    tree
    fd
    bat
    eza
    zsh-completions
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    gh
    neovim
    codex
    devbox
    claude-code
    zellij
    tree-sitter
    pyright
    ruff
    uv
    vtsls
    vscode-langservers-extracted
    vscode-js-debug
    typescript
    prettier
    stylua
    lua-language-server
    (python3.withPackages (ps: [ ps.pytest ps.pynvim ]))
    nodejs
    jdk17 # Android/Gradle compatibility; JAVA_HOME must match.
    android-tools

    # stockmatch-infra tooling
    opentofu
    docker
    colima
    caddy
    shellcheck
    awscli2
    python3Packages.debugpy # DAP python debugging
    cocoapods
    shopify-cli
    fastlane
    # headless iOS Simulator control (tap/type/screenshot) when Simulator.app is missing
    idb-companion
  ];

  programs = {
    # Enable Home Manager to manage your home directory.
    home-manager.enable = true;
    # direnv
    direnv.enable = true;
    zoxide.enable = true;
    fzf = {
      enable = true;
      historyWidget.command = ""; # Atuin owns Ctrl-R.
    };
    # Official macOS binary; the source-built ghostty package is Linux-only.
    ghostty = {
      enable = true;
      package = pkgs.ghostty-bin;
      settings = {
        theme = "Catppuccin Frappe";
        font-family = "JetBrainsMonoNL Nerd Font Mono";
        font-size = 13;
        cursor-style = "block";
        cursor-style-blink = false;
        shell-integration-features = "no-cursor,title,path";
        copy-on-select = "clipboard";
        macos-option-as-alt = "left";
        macos-titlebar-style = "tabs";
        window-padding-x = 10;
        window-padding-y = 8;
        window-padding-balance = true;
        # Keep Ghostty's native terminfo and keyboard protocol for tmux.
        term = "xterm-ghostty";
        keybind = [
          "super+shift+j=write_scrollback_file:copy"
          "super+t=new_tab"
          "super+n=new_window"
          "super+shift+h=previous_tab"
          "super+shift+l=next_tab"
          "super+shift+t=prompt_tab_title"
          "super+shift+backslash=new_split:right"
          "super+shift+minus=new_split:down"
          "super+shift+w=close_surface"
          "super+left=goto_split:left"
          "super+right=goto_split:right"
          "super+up=goto_split:up"
          "super+down=goto_split:down"
        ];
      };
    };
    # Enable and configure some basic programs.
    git = {
      enable = true;
      settings = {
        user.name = "bkp5190";
        user.email = "boneypatel37@yahoo.com";
        init.defaultBranch = "main";
        commit.gpgsign = true;
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = "yes";
        };
        "github.com" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_ed25519";
          IdentitiesOnly = true;
        };
        "github-gb" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_ed25519_gb";
          IdentitiesOnly = true;
        };
      };
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      dotDir = "${config.xdg.configHome}/zsh";

      shellAliases = {
        hms = "home-manager switch";
        lg = "lazygit";
        v = "nvim";
        c = "clear";
        fk = "fuck";
        cd = "z";
        s = "web_search duckduckgo";
      };
      oh-my-zsh = {
        enable = true;
        extraConfig = builtins.readFile ./extraConfig.zsh;
        plugins = [
          "web-search"
          "copyfile"
          "copybuffer"
        ];
      };
    };

    # Atuin terminal history scroller 
    atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        dialect = "us";
        style = "compact";
        inline_height = 15;
      };
    };

    # Starship shell prompt
    starship = {
      enable = true;
    };

    # tmux: Oh My Tmux! supplies keybindings/behavior, Catppuccin (frappe,
    # rounded windows) is layered on top for the status bar look.
    tmux = {
      enable = true;
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 50000;
      terminal = "tmux-256color";
      extraConfig = ''
        # Oh My Tmux runs shell helpers extracted from its own source file.
        set-environment -g TMUX_PROGRAM ${pkgs.tmux}/bin/tmux
        set-environment -g TMUX_CONF ${ohMyTmux}/.tmux.conf
        set-environment -g TMUX_CONF_LOCAL ${./tmux.conf.local}
        source-file ${ohMyTmux}/.tmux.conf
        run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux

        # Reload the complete Home Manager config, including Catppuccin.
        bind r source-file ${config.xdg.configHome}/tmux/tmux.conf


        # status bar modules, composed after Catppuccin loads
        set -g status-left-length 100
        set -g status-right-length 100
        set -g status-left "#{E:@catppuccin_status_session}"
        set -g status-right "#{E:@catppuccin_status_directory}"
        set -ag status-right "#{E:@catppuccin_status_date_time}"
      '';
    };
  };
}
