source libsetup.sh || exit 1

rc_append_line ~/.bashrc "bind -f ~/.inputrc"
rc_append_line ~/.inputrc "set bell-style none"
