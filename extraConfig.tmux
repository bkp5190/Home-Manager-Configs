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
set-option -g @plugin 'b0o/tmux-autoreload'
### PLUGINS ###
set -g @plugin 'o0th/tmux-nova'
set -g @plugin 'tmux-plugins/tmux-cpu'
set -g @plugin 'tmux-plugins/tmux-battery'
set -g @plugin 'ofirgall/tmux-keyboard-layout'

### THEME ###
set -g @nova-nerdfonts true
set -g @nova-nerdfonts-left 
set -g @nova-nerdfonts-right 

set -g @nova-pane "#I #W"
set -g @nova-rows 0

### COLORS ###
b_bg="#504945"

seg_a="#a89984 #282828"
seg_b="$b_bg #ddc7a1"

inactive_bg="#32302f"
inactive_fg="#ddc7a1"
active_bg=$b_bg
active_fg="#ddc7a1"

set -gw window-status-current-style bold
set -g "@nova-status-style-bg" "$inactive_bg"
set -g "@nova-status-style-fg" "$inactive_fg"
set -g "@nova-status-style-active-bg" "$active_bg"
set -g "@nova-status-style-active-fg" "$active_fg"

set -g "@nova-pane-active-border-style" "#44475a"
set -g "@nova-pane-border-style" "#827d51"

### STATUS BAR ###
set -g @nova-segment-prefix "#{?client_prefix,PREFIX,}"
set -g @nova-segment-prefix-colors "$seg_b"

set -g @nova-segment-session "#{session_name}"
set -g @nova-segment-session-colors "$seg_a"

set -g @nova-segment-whoami "#(whoami)@#h"
set -g @nova-segment-whoami-colors "$seg_a"

set -g @batt_icon_status_charging '↑'
set -g @batt_icon_status_discharging '↓'
set -g @nova-segment-battery "#{battery_icon_status} #{battery_percentage}"
set -g @nova-segment-battery-colors "$seg_b"

set -g @nova-segment-layout "#(~/.tmux/plugins/tmux-keyboard-layout/scripts/get_keyboard_layout.sh)"
set -g @nova-segment-layout-colors "$seg_a"

set -g @nova-segments-0-left "session"
set -g @nova-segments-0-right "prefix cpu battery layout whoami"
set -g @plugin 'tmux-plugins/tmux-sensible'

# Vim tmux navigator
set -g @plugin 'christoomey/vim-tmux-navigator'

# Work with p10k
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# set -g @plugin 'egel/tmux-gruvbox'
# set -g @tmux-gruvbox 'dark' # or 'light', 'dark-transparent', 'light-transparent'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
