# Rebind <leader> to C-w
set -g prefix C-w

# Allow mouse to resize windows
set -g mouse on

# Copying from tmux
setw -g mode-keys vi
set-option -g default-command "reattach-to-user-namespace -l $SHELL"
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
bind-key -T copy-mode-vi v send -X begin-selection
bind p paste-buffer

# Pane navigation bindings
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

# Bind kill pane to not prompt confirmation
bind-key x kill-pane

# Rebind splitting panes
bind n split-window -h -c "#{pane_current_path}"
bind f split-window -v -c "#{pane_current_path}"

# Bind for cycling windows
bind m next-window

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Vim tmux navigator
set -g @plugin 'christoomey/vim-tmux-navigator'

# Work with p10k
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# # Catppuccin for tmux
set -g @plugin 'catppuccin/tmux'

# # Configs for Catppuccin tmux
set -g @catppuccin_window_right_separator "█ "
set -g @catppuccin_window_number_position "right"
set -g @catppuccin_window_middle_separator " | "

set -g @catppuccin_window_default_fill "none"

set -g @catppuccin_window_current_fill "all"

set -g @catppuccin_status_modules_right "application session"
set -g @catppuccin_status_left_separator "█"
set -g @catppuccin_status_right_separator "█"

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name#branch'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
