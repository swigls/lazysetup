source fn.sh || exit 1

uninstall_check 'No beep feature'

rc_append_line $(installdir)/.bashrc "bind -f ~/.inputrc"
rc_append_line $(installdir)/.inputrc "set bell-style none"

rc_append_line $(installdir)/.vimrc "set visualbell"
rc_append_line $(installdir)/.vimrc "set t_vb="
