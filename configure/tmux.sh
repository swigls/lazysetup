source fn.sh || exit 1

rc_append ~/.tmux.conf "set-option -sg escape-time 10"
rc_append ~/.tmux.conf "set-option -g focus-events on"
rc_append ~/.tmux.conf "set-option -g default-terminal \"screen-256color\""
rc_append ~/.tmux.conf "set-option -a terminal-features 'XXX:RGB'"
