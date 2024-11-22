source fn.sh || exit 1

rc_append ~/.inputrc "set bell-style none"
source ~/.inputrc

rc_append ~/.vimrc "set visualbell"
rc_append ~/.vimrc "set t_vb="
source ~/.vimrc
