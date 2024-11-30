source fn.sh || exit 1

rc_append_line ~/.inputrc "set bell-style none"
rc_append_line ~/.bashrc "bind -f ~/.inputrc"

rc_append_line ~/.vimrc "set visualbell"
rc_append_line ~/.vimrc "set t_vb="
