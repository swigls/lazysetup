source fn.sh || exit 1

rc_append ~/.inputrc "set bell-style none"
rc_append ~/.bashrc "bind -f ~/.inputrc"

rc_append ~/.vimrc "set visualbell"
rc_append ~/.vimrc "set t_vb="
