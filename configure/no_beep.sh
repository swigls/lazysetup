source libsetup.sh || exit 1

rc_append_line "$(lazysetup_root)"/.bashrc "bind -f ~/.inputrc"
rc_append_line "$(lazysetup_root)"/.inputrc "set bell-style none"

rc_append_line "$(lazysetup_root)"/.vimrc "set visualbell"
rc_append_line "$(lazysetup_root)"/.vimrc "set t_vb="
