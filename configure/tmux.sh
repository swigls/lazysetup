source libsetup.sh || exit 1

rc_append_line $(lazysetup_root)/.tmux.conf "set-option -sg escape-time 10"
rc_append_line $(lazysetup_root)/.tmux.conf "set-option -g focus-events on"
rc_append_line $(lazysetup_root)/.tmux.conf "set-option -g default-terminal \"screen-256color\""
rc_append_line $(lazysetup_root)/.tmux.conf "set-option -a terminal-features 'xterm-256color:RGB'"
